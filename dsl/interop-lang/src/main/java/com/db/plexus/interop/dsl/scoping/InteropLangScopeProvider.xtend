/**
 * Copyright 2017 Plexus Interop Deutsche Bank AG
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * generated by Xtext 2.12.0
 */
package com.db.plexus.interop.dsl.scoping

import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.EObject
import com.db.plexus.interop.dsl.DslPackage
import com.db.plexus.interop.dsl.ConsumedMethod
import org.eclipse.xtext.EcoreUtil2
import com.db.plexus.interop.dsl.ConsumedService
import com.db.plexus.interop.dsl.protobuf.Method
import org.eclipse.xtext.scoping.Scopes
import com.db.plexus.interop.dsl.ProvidedMethod
import com.db.plexus.interop.dsl.ProvidedService

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class InteropLangScopeProvider extends AbstractInteropLangScopeProvider {

	override getScope(EObject context, EReference reference) {
		
		if (context instanceof ConsumedMethod && reference == DslPackage.Literals.CONSUMED_METHOD__METHOD) {
			val consumedService = EcoreUtil2.getContainerOfType(context, typeof(ConsumedService))
			val service = consumedService.service
			val serviceMethods = EcoreUtil2.getAllContentsOfType(service, typeof(Method))
			return Scopes.scopeFor(serviceMethods)
		}
		
		if (context instanceof ProvidedMethod && reference == DslPackage.Literals.PROVIDED_METHOD__METHOD) {
			val providedService = EcoreUtil2.getContainerOfType(context, typeof(ProvidedService))
			val service = providedService.service
			val serviceMethods = EcoreUtil2.getAllContentsOfType(service, typeof(Method))
			return Scopes.scopeFor(serviceMethods)
		}
		
		return super.getScope(context, reference);
	}

}
