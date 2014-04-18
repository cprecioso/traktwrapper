# TRAKT.TV METHODS LIST
# Documented in http://trakt.tv/api-docs

# The URL SHOULDN'T contain the format parameter (add .json to the route), nor should JSON contain the username and password parameters, as these get handled by traktwrapper automatically

# You migh want to unset the line wrap for this file...

# MACROS
G = (...args) -> [\GET] ++ args		# GET method shorthand
P = (...args) -> [\POST] ++ args	# POST method shorthand

# RETURN VALUE
[
#METHOD	ROUTE									URL														QS						JSON
P		\account/create							void													void					\email
P		\account/test							void													void					void
P		\account/settings						void													void					void

#METHOD	ROUTE									URL														QS						JSON
G		\activity/community.json				\types/actions/start_ts/end_ts							\min/images				void
G		\activity/episodes.json					\title/season/episode/actions/start_ts/end_ts			\min/images				void
G		\activity/friends.json					\types/actions/start_ts/end_ts							\min/images				void
G		\activity/movies.json					\title/actions/start_ts/end_ts							\min/images				void
G		\activity/seasons.json					\title/season/actions/start_ts/end_ts					\min/images				void
G		\activity/shows.json					\title/actions/start_ts/end_ts							\min/images				void
G		\activity/user.json						\username/types/actions/start_ts/end_ts					\min/images				void
G		\activity/user/episodes.json			\username/title/season/episode/actions/start_ts/end_ts	\min/images				void
G		\activity/user/movies.json				\username/title/actions/start_ts/end_ts					\min/images				void
G		\activity/user/seasons.json				\username/title/season/actions/start_ts/end_ts			\min/images				void
G		\activity/user/shows.json				\username/title/actions/start_ts/end_ts					\min/images				void

#METHOD	ROUTE									URL														QS						JSON
G		\calendar/premieres.json				\date/days												void					void
G		\calendar/shows.json					\date/days												void					void

#METHOD	ROUTE									URL														QS						JSON
P		\comment/episode						void													void					\tvdb_id/imdb_id/title/year/season/episode/comment/spoiler/review
P		\comment/movie							void													void					\imdb_id/tmdb_id/title/year/comment/spoiler/review
P		\comment/show							void													void					\tvdb_id/imdb_id/title/year/comment/spoiler/review

#METHOD	ROUTE									URL														QS						JSON
G		\genres/movies.json						void													void					void
G		\genres/shows.json						void													void					void

#METHOD	ROUTE									URL														QS						JSON
P		\lists/add								void													void					\name/description/privacy/show_numbers/allow_shouts
P		\lists/delete							void													void					\slug
P		\lists/items/add						void													void					\slug/items
P		\lists/items/delete						void													void					\slug/items
P		\lists/update							void													void					\slug/name/description/privacy/show_numbers/allow_shouts

#METHOD	ROUTE									URL														QS						JSON
P		\movie/cancelcheckin					void													void					void
P		\movie/cancelwatching					void													void					void
P		\movie/checkin							void													void					\imdb_id/tmdb_id/title/year/duration/venue_id/venue_name/share/message/app_version/app_date
G		\movie/comments.json					\title/type												void					void
P		\movie/scrobble							void													void					\imdb_id/tmdb_id/title/year/duration/progress/plugin_version/media_center_version/media_center_date
P		\movie/seen								void													void					\movies
P		\movie/library							void													void					\movies
G		\movie/related.json						\title/hidewatched										void					void
G		\movie/stats.json						\title													void					void
G		\movie/summary.json						\title													void					void
G		\movie/summaries.json					\title/extended											void					void
P		\movie/unlibrary						void													void					\movies
P		\movie/unseen							void													void					\movies
P		\movie/unwatchlist						void													void					\movies
P		\movie/watching							void													void					\imdb_id/tmdb_id/title/year/duration/progress/plugin_version/media_center_version/media_center_date
G		\movie/watchingnow						\title													void					void
P		\movie/watchlist						void													void					\movies

#METHOD	ROUTE									URL														QS						JSON
G		\movies/trending.json					void													void					void
G		\movies/updated.json					\timestamp												void					void

#METHOD	ROUTE									URL														QS						JSON
P		\network/approve						void													void					\user/follow_back
P		\network/deny							void													void					\user
P		\network/follow							void													void					\user
P		\network/requests						void													void					void
P		\network/unfollow						void													void					\user

#METHOD	ROUTE									URL														QS						JSON
P		\rate/episode							void													void					\tvdb_id/imdb_id/title/year/season/episode/rating
P		\rate/episodes							void													void					\episodes
P		\rate/movie								void													void					\imdb_id/tmdb_id/title/year/rating
P		\rate/movies							void													void					\movies
P		\rate/show								void													void					\tvdb_id/imdb_id/title/year/rating
P		\rate/shows								void													void					\shows

#METHOD	ROUTE									URL														QS						JSON
P		\recommendations/movies					void													void					\genre/start_year/end_year/hide_collected/hide_watchlisted
P		\recommendations/movies/dismiss			void													void					\imdb_id/tmdb_id/title/year
P		\recommendations/shows					void													void					\genre/start_year/end_year/hide_collected/hide_watchlisted
P		\recommendations/shows/dismiss			void													void					\tvdb_id/title/year

#METHOD	ROUTE									URL														QS						JSON
G		\search/episodes.json					void													\query/limit			void
G		\search/movies.json						void													\query/limit			void
G		\search/people.json						void													\query/limit			void
G		\search/shows.json						void													\query/limit/seasons	void
G		\search/users.json						void													\query/limit			void

#METHOD	ROUTE									URL														QS						JSON
G		\server/time.json						void													void					void

#METHOD	ROUTE									URL														QS						JSON
P		\show/cancelcheckin						void													void					void
P		\show/cancelwatching					void													void					void
P		\show/checkin							void													void					\tvdb_id/title/year/season/episode/episode_tvdb_id/duration/venue_id/venue_name/share/message/app_version/app_date
G		\show/comments.json						\title/type												void					void
G		\show/episode/comments.json				\title/season/episode/type								void					void
P		\show/episode/library					void													void					\imdb_id/tvdb_id/title/year/episodes
P		\show/episode/seen						void													void					\imdb_id/tvdb_id/title/year/episodes
G		\show/episode/stats.json				\title/season/episode									void					void
G		\show/episode/summary.json				\title/season/episode									void					void
P		\show/episode/unlibrary					void													void					\imdb_id/tvdb_id/title/year/episodes
P		\show/episode/unseen					void													void					\imdb_id/tvdb_id/title/year/episodes
P		\show/episode/unwatchlist				void													void					\imdb_id/tvdb_id/title/year/episodes
G		\show/episode/watchingnow.json			\title/season/episode									void					void
P		\show/episode/unwatchlist				void													void					\imdb_id/tvdb_id/title/year/episodes
P		\show/library							void													void					\imdb_id/tvdb_id/title/year
G		\show/related.json						\title/extended/hidewatched								void					void
P		\show/scrobble							void													void					\tvdb_id/title/year/season/episode/episode_tvdb_id/duration/progress/plugin_version/media_center_version/media_center_date
G		\show/season.json						\title/season											void					void
P		\show/season/library					void													void					\imdb_id/tvdb_id/title/year/season
P		\show/season/seen						void													void					\imdb_id/tvdb_id/title/year/season
G		\show/seasons.json						\title													void					void
P		\show/seen								void													void					\imdb_id/tvdb_id/title/year
G		\show/stats.json						\title													void					void
G		\show/summary.json						\title/extended											void					void
G		\show/summaries.json					\title/extended											void					void
P		\show/unlibrary							void													void					\imdb_id/tvdb_id/title/year
P		\show/unwatchlist						void													void					\shows
P		\show/watching							void													void					\tvdb_id/imdb_id/title/year/season/episode/episode_tvdb_id/duration/progress/plugin_version/media_center_version/media_center_date
G		\show/watchingnow.json					\title													void					void
P		\show/watchlist							void													void					\shows

#METHOD	ROUTE									URL														QS						JSON
G		\shows/trending.json					void													void					void
G		\shows/updated.json						\timestamp												void					void

#METHOD	ROUTE									URL														QS						JSON
G		\user/calendar/shows.json				\username/date/days										void					void
G		\user/lastactivity.json					\username												void					void
G		\user/library/movies/all.json			\username/extended										void					void
G		\user/library/movies/collection.json	\username/extended										void					void
G		\user/library/movies/watched.json		\username/extended										void					void
G		\user/library/shows/all.json			\username/extended										void					void
G		\user/library/shows/collection.json		\username/extended										void					void
G		\user/library/shows/watched.json		\username/extended										void					void
G		\user/list.json							\username/slug											void					void
G		\user/lists.json						\username												void					void
G		\user/network/followers.json			\username												void					void
G		\user/network/following.json			\username												void					void
G		\user/network/friends.json				\username												void					void
G		\user/profile.json						\username												void					void
G		\user/progress/collected.json			\username/title/sort/extended							void					void
G		\user/progress/watched.json				\username/title/sort/extended							void					void
G		\user/ratings/episodes.json				\username/rating/extended								void					void
G		\user/ratings/movies.json				\username/rating/extended								void					void
G		\user/ratings/shows.json				\username/rating/extended								void					void
G		\user/watching.json						\username												void					void
G		\user/watchlist/episodes.json			\username												void					void
G		\user/watchlist/movies.json				\username												void					void
G		\user/watchlist/shows.json				\username												void					void
]
