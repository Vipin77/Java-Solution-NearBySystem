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
		
		addDefaultLayoutDef("loginPage", TilesIConstant.BODY,"", "");
		
		addDefaultLayoutDef("adminHomePage", TilesIConstant.HOME_PAGE,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("addCategory", TilesIConstant.ADD_CATEGORY,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("addSp", TilesIConstant.ADD_SP,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("addSubCategory", TilesIConstant.ADD_SUBCATEGORY,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("userHome", TilesIConstant.USER_HOME,"", "");
		
		addDefaultLayoutDef("searchSp", TilesIConstant.SEARCH_SP,TilesIConstant.HEADER, TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("userLoginPage", TilesIConstant.USERLOGIN_PAGE,"","");
		
		addDefaultLayoutDef("userRegistration", TilesIConstant.USERREGISTRATION_PAGE,"", TilesIConstant.FOOTER);
		
		addDefaultLayoutDef("spHome", TilesIConstant.SP_HOME,"", "");
		
		addDefaultLayoutDef("spLoginPage", TilesIConstant.SPLOGIN_PAGE,"","");
	}
}
