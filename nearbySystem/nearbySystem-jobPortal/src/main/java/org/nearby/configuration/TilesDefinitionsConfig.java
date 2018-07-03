package org.nearby.configuration;

import java.util.HashMap;
import java.util.Map;

import org.apache.tiles.Attribute;
import org.apache.tiles.Definition;
import org.apache.tiles.definition.DefinitionsFactory;
import org.nearby.utils.TilesIConstant;

public final class TilesDefinitionsConfig implements DefinitionsFactory {
	
	private static final Map<String, Definition> tilesDefinitions = new HashMap<String, Definition>();
	private static final Attribute BASE_TEMPLATE = new Attribute(TilesIConstant.DEFAULT_LAYOUT);
    
	public Definition getDefinition(String name,org.apache.tiles.request.Request tilesContext)
	{
		return tilesDefinitions.get(name);
	}


	private static void addDefaultLayoutDef(String name, String body, String header, String footer) {
		Map<String, Attribute> attributes = new HashMap<String, Attribute>();

		attributes.put("header", new Attribute(header));
		attributes.put("body", new Attribute(body));
		attributes.put("footer", new Attribute(footer));
		tilesDefinitions.put(name, new Definition(name, BASE_TEMPLATE, attributes));
	}

	public static void addDefinitions() {
		
		addDefaultLayoutDef("portalHome", TilesIConstant.BODY,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("postJob", TilesIConstant.POST_JOB,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("searchJob", TilesIConstant.SEARCH_JOB,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		addDefaultLayoutDef("editPostedJob", TilesIConstant.EDIT_POSTED_JOB,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		 
		addDefaultLayoutDef("portalLoginPage", TilesIConstant.PORTAL_LOGIN,"", "");
		
		addDefaultLayoutDef("registerEmployer", TilesIConstant.EMPLOYER_REGISTRATION,"", "");
		addDefaultLayoutDef("registerEmployee", TilesIConstant.EMPLOYEE_REGISTRATION,"", "");
	
		addDefaultLayoutDef("portalHomeEmployee", TilesIConstant.EMPLOYEE_BODY,TilesIConstant.EMPLOYEE_HEADER, TilesIConstant.FOOTER);
		addDefaultLayoutDef("availableJob", TilesIConstant.AVAILABLE_JOB,TilesIConstant.EMPLOYEE_HEADER, TilesIConstant.FOOTER);
		addDefaultLayoutDef("viewAvailableEmployee", TilesIConstant.VIEWAVAILABLE_EMPLOYEE,TilesIConstant.HEADER, TilesIConstant.FOOTER);
	}
}
