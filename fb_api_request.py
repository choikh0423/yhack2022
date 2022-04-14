import requests, facebook, json, time

# Getting User Token for Facebook Graph API
user_token = 'EAAKh8qpAhWIBAJQwc99ZAYuasCmuO07JyMbe8KPfS4Hys1oeTaEW2KKqUZCZBOQSP7RHExPCPsTIdFl76TCbhCZANwFSI43fitQE8zfCSZB7TEAKVPXfKPbXYMAcEZBAPbtfttTPC1dcycNyOXHyXjFMVYaF2hqQjKNC6Wkp11uis4SBcUQphT5oGh7o4u3bjwJTngjN0V9EMWacqRZBYNOTQjQCVtI19df1foICnocs23MNZCqS8GYG'
graph = facebook.GraphAPI(user_token)
profile = graph.get_object("me", fields="posts")

posts_dict = profile['posts']


# This Function retrieves all the posts from one page
def get_page_posts(posts_dict):
    posts = posts_dict['data']
    post_infos = []

    for post in posts:
        try:
            created_date = post['created_time'][:10]
            message = post['message']
            url = "https://www.facebook.com/" + post['id']
        except:
            message = None


        if message:
            comb = [created_date, "Facebook", "Post", url, message]
            post_infos.append(comb)
        

    return post_infos

# This Function returns all the posts from all the pages
def get_all_posts(posts_dict):
    pages = posts_dict['paging']
    data = posts_dict['data']
    new_post_dict = posts_dict
    all_posts =[]


    while data != []:
        page_posts = get_page_posts(new_post_dict)
        all_posts.extend(page_posts)

        next_page = pages['previous']

        next_request = requests.get(next_page)

        new_post_dict = next_request.json()
        data = new_post_dict['data']

    return all_posts
    
print(get_all_posts(posts_dict))

