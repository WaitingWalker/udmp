package de.koizumi.sleuth.annotation;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.sleuth.Span;
import org.springframework.cloud.sleuth.Tracer;

public class DefaultSleuthSpanCreator implements SleuthSpanCreator {
	
	private Tracer tracer;
	private SleuthSpanTagAnnotationHandler annotationSpanUtil;

	@Autowired
	public DefaultSleuthSpanCreator(Tracer tracer, SleuthSpanTagAnnotationHandler annotationSpanUtil) {
		this.tracer = tracer;
		this.annotationSpanUtil = annotationSpanUtil;
	}

	@Override
	public Span createSpan(JoinPoint pjp, CreateSleuthSpan createSleuthSpanAnnotation) {
		if (tracer.isTracing()) {
			String key = StringUtils.isNotEmpty(createSleuthSpanAnnotation.name()) ? createSleuthSpanAnnotation.name() : pjp.getSignature().getDeclaringType().getSimpleName() + "/" + pjp.getSignature().getName();
			Span span = tracer.createSpan(key, tracer.getCurrentSpan());
			annotationSpanUtil.addAnnotatedParameters(pjp);
			return span;
		}
		return null;
	}

}
