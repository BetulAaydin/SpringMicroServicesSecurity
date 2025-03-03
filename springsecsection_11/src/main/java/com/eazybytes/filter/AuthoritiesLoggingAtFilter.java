package com.eazybytes.filter;

import jakarta.servlet.*;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;


public class AuthoritiesLoggingAtFilter implements Filter {
    /**
     * @param request  The request to process
     * @param response The response associated with the request
     * @param chain    Provides access to the next filter in the chain for this filter to pass the request and response
     *                 to for further processing
     * @throws IOException
     * @throws ServletException
     */
    private static final org. slf4j. Logger log
            = org. slf4j. LoggerFactory. getLogger(AuthoritiesLoggingAtFilter.class);
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        log.info("Authentication Validation is in progress");
        chain.doFilter(request,response);
    }
}
