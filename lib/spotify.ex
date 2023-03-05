defmodule Spotify do
  use HTTPoison.Base

  defp auth_headers() do
    token = File.read!("./secret.json")
    {:ok, %{"access_token" => access_token}} = Jason.decode(token)
    [
      {"Authorization", "Bearer #{access_token}"}
    ]
  end

  def new_playlist(name, user_id) do
    HTTPoison.start()

    body_map = %{"name" => name, "public" => false}
    response =
      HTTPoison.post!(
        "https://api.spotify.com/v1/users/#{user_id}/playlists",
        Jason.encode!(body_map),
        [{"Content-Type", "application/json"} | auth_headers()]
      )
    {:ok, %{"id" => playlist_id}} = Jason.decode(response.body)
    playlist_id
  end

  def add_song(playlist_id, song_id) do
    HTTPoison.start()

    song = ["spotify:track:#{song_id}"]
    response =
      HTTPoison.post!(
        "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks",
        Jason.encode!(song),
        [{"Content-Type", "application/json"} | auth_headers()]
      )
    response
  end

  def change_image(playlist_id, image_path) do
    HTTPoison.start()

    image = File.read!(image_path)
    base64 = Base.encode64(image)
    response =
      HTTPoison.put!(
        "https://api.spotify.com/v1/playlists/#{playlist_id}/images",
        base64,
        [{"Content-Type", "image/jpeg"} | auth_headers()]
      )
    response
  end

  def get_user_id() do
    HTTPoison.start()

    response =
      HTTPoison.get!(
        "https://api.spotify.com/v1/me",
        [{"Content-Type", "application/json"} | auth_headers()]
      )
    {:ok, %{"id" => user_id}} = Jason.decode(response.body)
    user_id
  end

  def get_song_id() do
    "2C4jYVZId6mxISa3HrBvGM"
  end

  def get_image_path() do
    "./cover.jpg"
  end
end
