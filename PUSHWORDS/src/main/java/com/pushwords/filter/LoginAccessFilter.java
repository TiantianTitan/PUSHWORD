package com.pushwords.filter;

import com.pushwords.po.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class LoginAccessFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest)  servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getRequestURI();

        // 1. Page accessible : login.jsp,register.jsp ..
        if(path.contains("/login.jsp")){
            filterChain.doFilter(request,response);
            return;
        }

        // 2. Resource accessible : statics ...
        if(path.contains("/statics")){
            filterChain.doFilter(request,response);
            return;
        }

        // 3. Action accessible : actionName ...
        if(path.contains("/user")){
            String actionName = request.getParameter("actionName");
            if("login".equals(actionName)){
                filterChain.doFilter(request,response);
                return;
            }
        }

        // 4. Stat login
        User user = (User) request.getSession().getAttribute("user");
        if(user != null){
            filterChain.doFilter(request,response);
            return;
        }

        // redirect to login
        response.sendRedirect("login.jsp");

    }
    @Override
    public void destroy() {
    }
}
