defmodule ClaperWeb.Components.Theme do
  @moduledoc """
  Light/dark theme switching. `init/1` goes in `<head>` so the theme is applied
  before first paint; `toggle/1` renders the floating switch button.
  """
  use Phoenix.Component

  def init(assigns) do
    ~H"""
    <script>
      (function () {
        var KEY = "claper-theme";
        function current() {
          try {
            var t = localStorage.getItem(KEY);
            if (t === "claper" || t === "claper-dark") return t;
          } catch (e) {}
          return window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches
            ? "claper-dark"
            : "claper";
        }
        document.documentElement.setAttribute("data-theme", current());
        window.claperToggleTheme = function () {
          var next = document.documentElement.getAttribute("data-theme") === "claper-dark" ? "claper" : "claper-dark";
          document.documentElement.setAttribute("data-theme", next);
          try { localStorage.setItem(KEY, next); } catch (e) {}
        };
      })();
    </script>
    """
  end

  def toggle(assigns) do
    ~H"""
    <button
      type="button"
      onclick="claperToggleTheme()"
      class="theme-toggle"
      title="Toggle light / dark mode"
      aria-label="Toggle light / dark mode"
    >
      <svg class="theme-toggle-moon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z" /></svg>
      <svg class="theme-toggle-sun" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4" /><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4" /></svg>
    </button>
    """
  end
end
