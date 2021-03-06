module Web.View.Posts.Show where

import qualified Text.MMark as MMark
import Web.View.Prelude

data ShowView = ShowView {post :: Post}

instance View ShowView where
  html ShowView {..} =
    [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">Show Post</li>
            </ol>
        </nav>
        <h1>{get #title post}</h1>
        <p>{get #createdAt post |> timeAgo}</p>
        <div>{get #body post |> renderMarkdown}</div>
    |]

renderMarkdown text =
  case MMark.parse "" text of
    Left err -> "OOPSIES"
    Right v -> MMark.render v |> tshow |> preEscapedToHtml
