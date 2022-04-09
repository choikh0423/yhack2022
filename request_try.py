import requests, facebook, json, time

user_token = 'EAAD5Ug4ZBRlsBAG6DDOfysFF8vZBL9pW7Xkz3ZBLiQc4IDeLR07XxNxWs3DkrhZBXq8W9NJA1DA5wp1YKN5vAp6V82BEyD0kZADiJXt7lagsL3DpwsdhSK91eVUGhZBDGLu84WqZAcOQAysCNDF3kBD7DSkQUF8yZC0lIv9oEHlmmw3p0CkuHl0NzD2E9JGz5EBFt1dToZACxor65KQKaoBkStjZCA8lG4kUxZAZAcNKE23pbqfMwYrU3KJs'

graph = facebook.GraphAPI(user_token)
profile = graph.get_object("me", fields="posts")
posts_dict = profile['posts']


def get_page_posts(posts_dict):
    posts = posts_dict['data']
    post_infos = []

    for post in posts:
        try:
            created_date = post['created_time']
            message = post['message']
            url = "www.facebook.com/" + post['id']
        except:
            message = None


        if message:
            comb = [created_date, "facebook", "post", url, message]
            post_infos.append(comb)
        

    return post_infos

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




# print(posts)
# print(post_infos)
# print(posts_dict['paging'])

# Pagination
# Comment
# 
# print(posts_dict)


# page_posts = get_page_posts(posts_dict)

# prev_request = requests.get(posts_dict['paging']['previous'])
# prev = prev_request.json()
# next_request = requests.get(posts_dict['paging']['next'])
# next = next_request.json()
# page_posts2 = get_page_posts(next)

# page_posts.extend(page_posts2)



# print(page_posts2)


#Go across Page
# print(graph.get_object(posts['posts']['messages']))