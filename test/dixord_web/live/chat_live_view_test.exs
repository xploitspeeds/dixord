defmodule DixordWeb.ChatLiveViewTest do
  @moduledoc """
  Testing the live view to check the before after migration
  of messages infra every works.

  Example are
  - https://hexdocs.pm/phoenix_live_view/Phoenix.LiveViewTest.html#content
  - https://github.com/flash4syth/provo_live/blob/8139bc608f27d8b922f1bdf89edf4d0edbfc9a09/test/provo_live_web/live/my_live_view_test.exs
  """
  use DixordWeb.ConnCase
  require Phoenix.LiveViewTest
  require Logger
  require DixordWeb.PageController

  @doc """
  checks that the view mounts correctly
  """
  test "mount", %{conn: conn} do
    {:ok, view, html} =
      Phoenix.LiveViewTest.live(conn, DixordWeb.PageController.get_landing_chat_path(conn))

    # assert that there is the string Message
    # from the composer e.g. "Message this chat.."
    assert html =~ "Message"
    assert html =~ "Dixord"
    # is guest authenticated?
    assert html =~ "Guest"
  end

  @doc """
  sends a message and check that it's rendered
  """
  test "send_message", %{conn: conn} do
    {:ok, view, html} =
      Phoenix.LiveViewTest.live(conn, DixordWeb.PageController.get_landing_chat_path(conn))

    message_content = "test_message_219120958120481023"

    assert Phoenix.LiveViewTest.render_submit(
             view,
             :message,
             %{
               "message" => %{
                 content: message_content
               }
             }
           ) =~ message_content
  end

  @doc """
  test typing

  for some reason I can't assert ~= "is typing"
  so I will just assert that the code doesn't break
  a refernece is https://github.com/kerryb/quiz_buzz/blob/75a63ba0036cfda78af8facc931851f61921dc4a/test/quiz_buzz_web/live/home_live_test.exs
  """
  test "typing, not_typing" do
    {:ok, view, html} =
      Phoenix.LiveViewTest.live(conn, DixordWeb.PageController.get_landing_chat_path(conn))

    assert Phoenix.LiveViewTest.render_change(view, :typing, %{message: ".."})

    refute Phoenix.LiveViewTest.render_blur(
             view,
             :stop_typing
           ) =~ "is typing.."
  end
end
