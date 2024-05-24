package com.pushwords.filter;

import com.pushwords.po.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * LoginAccessFilter handles access control for the application, ensuring that users are
 * logged in before accessing certain resources.
 */
@WebFilter("/*")
public class LoginAccessFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    /**
     * Filters incoming requests to enforce login access control.
     *
     * @param servletRequest  the ServletRequest object that contains the client's request
     * @param servletResponse the ServletResponse object that contains the filter's response
     * @param filterChain     the FilterChain for invoking the next filter or the resource
     * @throws IOException      if an I/O error occurs during the processing of the request
     * @throws ServletException if a servlet error occurs during the processing of the request
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getRequestURI();

        // 1. Allow access to login and signup pages
        if (path.contains("/login.jsp") || path.contains("/signup.jsp")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 2. Allow access to static resources
        if (path.contains("/statics")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 3. Allow access to specific user actions like login and register
        if (path.contains("/user")) {
            String actionName = request.getParameter("actionName");
            if ("login".equals(actionName) || "register".equals(actionName)) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        // 4. Check if user is already logged in
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            filterChain.doFilter(request, response);
            return;
        }

        // 5. Check for 'remember me' cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user".equals(cookie.getName())) {
                    String[] strings = cookie.getValue().split("-");
                    String userName = strings[0];
                    String userPwd = strings[1];
                    String url = "user?actionName=login&rem=1&userName=" + userName + "&userPwd=" + userPwd;
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                }
            }
        }

        // Redirect to login page if none of the above conditions are met
        response.sendRedirect("login.jsp");
    }

    @Override
    public void destroy() {
    }
}
