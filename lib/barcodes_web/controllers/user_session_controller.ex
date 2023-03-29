defmodule BarcodesWeb.UserSessionController do
  use BarcodesWeb, :controller

  alias Barcodes.Accounts
  alias BarcodesWeb.UserAuth

  plug :put_layout, "session.html"

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if IO.inspect(user = Accounts.get_user_by_email_and_password(email, password)) do
     UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> redirect(to: "/users/log_in")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "See You later.")
    |> UserAuth.log_out_user()
  end
end
