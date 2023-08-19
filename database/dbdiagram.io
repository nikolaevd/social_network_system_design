Table profiles {
  id uuid [pk]
  name varchar [not null]
  description varchar
  city_id uuid
  photo_id uuid
}

Table cities {
  id uuid [pk]
  name varchar [not null, unique]
}

Ref: profiles.city_id > cities.id

Table interests {
  id uuid [pk]
  name varchar [not null, unique]
}

Table profile_to_interest {
  profile_id integer [not null]
  interest_id integer [not null]
  Indexes {
        (profile_id, interest_id) [unique]
    }
}

Ref: profile_to_interest.profile_id > profiles.id
Ref: profile_to_interest.interest_id > interests.id

enum media_type {
    photo
    audio
    video
}

Table media {
  id uuid [pk]
  content blob [not null]
  type media_type [not null]
}

Ref: profiles.photo_id > media.id

Table posts {
  id uuid [pk]
  description varchar [not null]
  media_id uuid
  view_counter integer
  comments varchar[]
}

Ref: posts.media_id > media.id

Table hashtags {
   id uuid [pk]
   name varchar [not null, unique]
}

Table post_to_hashtag {
  post_id uuid [not null]
  hashtag_id uuid [not null]
  Indexes {
    (post_id, hashtag_id) [unique]
  }
}

Ref: post_to_hashtag.post_id > posts.id
Ref: post_to_hashtag.hashtag_id > hashtags.id

Table likes {
  post_id uuid [not null]
  profile_id uuid [not null]
  Indexes {
    (post_id, profile_id) [unique]
  }
}

Ref: likes.post_id > posts.id
Ref: likes.profile_id > profiles.id

Table messages {
  id uuid pk
  text varchar [not null]
  send_at timestamp [not null]
  was_readed boolean [not null, default: false]
  sender_id uuid [not null]
  recipien_id uuid [not null]
}

Ref: messages.sender_id > profiles.id
Ref: messages.recipien_id > profiles.id

enum relation_type {
    friend
    subscriber
    lover
    family
}

Table relations {
  first_profile_id uuid [not null]
  second_profile_id uuid [not null]
  relation relation_type [not null]
  Indexes {
    (first_profile_id, second_profile_id) [unique]
  }
}

Ref: relations.first_profile_id > profiles.id
Ref: relations.second_profile_id > profiles.id