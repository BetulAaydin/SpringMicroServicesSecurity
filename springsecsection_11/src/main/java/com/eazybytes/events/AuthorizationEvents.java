package com.eazybytes.events;


import org.springframework.context.event.EventListener;
import org.springframework.security.authorization.event.AuthorizationDeniedEvent;
import org.springframework.stereotype.Component;

@Component

public class AuthorizationEvents {
    private static final org. slf4j. Logger log
            = org. slf4j. LoggerFactory. getLogger(AuthorizationEvents.class);
    @EventListener
    public void onFailure(AuthorizationDeniedEvent deniedEvent) {
        log.error("Authorization failed for the user : {} due to : {}", deniedEvent.getAuthentication().get().getName(),
                deniedEvent.getAuthorizationDecision().toString());
    }

}
