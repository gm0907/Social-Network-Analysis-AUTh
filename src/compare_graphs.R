# Load unique users data
users <- read.csv("output/unique_users.txt")
head(users)

# Compare retweet_graphs
my_rt_graph <- read.csv("data/processed/retweet_graph_partial.csv", stringsAsFactors = F)
rt_graph <- read.csv("data/processed/retweet_graph1.csv", stringsAsFactors = F)


nrow(my_rt_graph) # 10078
nrow(rt_graph)    # 20501
 

# Duplicates
sum(duplicated(my_rt_graph)) # 0 
sum(duplicated(rt_graph))    # 9123


head(my_rt_graph)
head(rt_graph)

# Join name
rt_graph <- merge(x = rt_graph, y = users, by.x = c("Source"), by.y = c("user_id"))
rt_graph <- rt_graph %>% rename(source_screen_name = screen_name)
 
rt_graph <- merge(x = rt_graph, y = users, by.x = c("Target"), by.y = c("user_id"))
rt_graph <- rt_graph %>% rename(target_screen_name = screen_name)

head(rt_graph)

rt_graph$source_screen_name <- as.character(rt_graph$source_screen_name)
rt_graph$target_screen_name <- as.character(rt_graph$target_screen_name)

# Count unique users
a <- c(my_rt_graph$screen_name, my_rt_graph$mentions_screen_name) %>% unique()
a
a %>% length() # 5194

b <- c(rt_graph$source_screen_name, rt_graph$target_screen_name) %>% unique() 
b
b %>% length()  # 2564


setdiff(a,b)
setdiff(b,a)


# Sanity check on twitter_data:
twitter_data <- read.csv("data/raw/with_retweets.csv")
colnames(twitter_data)

rt_graph %>% filter(target_screen_name == "DataScienceNott")

twitter_data %>% filter(screen_name == "allison_horst") %>% View()
