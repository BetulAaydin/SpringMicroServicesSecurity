package com.eazybytes.events;


import org.apache.commons.logging.Log;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.AbstractAuthenticationFailureEvent;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.stereotype.Component;

@Component

public class AuthenticationEvents {
    private static final org. slf4j. Logger log
            = org. slf4j. LoggerFactory. getLogger(AuthenticationEvents.class);
    @EventListener
    public void onSuccess(AuthenticationSuccessEvent successEvent) {

        log.info("Login successful for the user : {}", successEvent.getAuthentication().getName());
    }

    @EventListener
    public void onFailure(AbstractAuthenticationFailureEvent failureEvent) {
        log.error("Login failed for the user : {} due to : {}", failureEvent.getAuthentication().getName(),
                failureEvent.getException().getMessage());
    }

}
