package com.eazybytes.logging;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.logging.LogLevel;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Aspect
@Configuration
public class LoggingAspect {
    private static final Logger LOGGER = LoggerFactory.getLogger(LoggingAspect.class);

    @Before(value = "@within(loggable)")
    public void logInputParameterOfMethods(JoinPoint jointPoint, Loggable loggable) {
        String classNameAndMethodName = getClassNameAndMethodName(jointPoint);
        Object[] signatureArgs = jointPoint.getArgs();
        if (isLogLevelForLoggableInfo(loggable)) {
            LOGGER.info("Input parameters of {} are: {}", classNameAndMethodName, signatureArgs);
        } else if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("Input parameters of {} are: {}", classNameAndMethodName, signatureArgs);
        }
    }

    public void logReturnParametersOfMethods(JoinPoint joinPoint, Loggable loggable, Object result) {
        String classNameAndMethodName = getClassNameAndMethodName(joinPoint);
        if (isLogLevelForLoggableInfo(loggable)) {
            if (result != null) {
                ResponseEntity<Object> responseEntity = (ResponseEntity<Object>) result;
                if (responseEntity.getStatusCode() != HttpStatus.OK) {
                    LOGGER.info("Return parameters of {} are: {}", classNameAndMethodName, result);
                } else {
                    LOGGER.info("Request returned from {} with status code: {}", classNameAndMethodName, responseEntity.getStatusCode());
                }
            } else {
                LOGGER.info("Return parameters of {} is null value. ", classNameAndMethodName);
            }
        }else if (LOGGER.isDebugEnabled()){
            if (result != null) {
                LOGGER.info("Return parameters of {} are: {}", classNameAndMethodName, result);
            } else {
                LOGGER.info("Request returned from {} is null value.", classNameAndMethodName);
            }
        }
    }

    private boolean isLogLevelForLoggableInfo(Loggable loggable) {
        return loggable.type().getLogLevel() == LogLevel.INFO;
    }

    private String getClassNameAndMethodName(JoinPoint joinpoint){
        MethodSignature methodSignature = (MethodSignature) joinpoint.getSignature();
        return methodSignature.getDeclaringType().getSimpleName() + "." + methodSignature.getName();
    }
}