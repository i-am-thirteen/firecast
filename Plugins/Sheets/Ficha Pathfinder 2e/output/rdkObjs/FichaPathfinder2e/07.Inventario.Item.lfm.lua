require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmInventarioItem()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmInventarioItem");
    obj:setWidth(465);
    obj:setHeight(25);
    obj:setTheme("dark");
    obj:setMargins({top=1});

			
		local function askForDelete()
			Dialogs.confirmYesNo("Deseja realmente apagar esse item?",
								 function (confirmado)
									if confirmado then
										NDB.deleteNode(sheet);
									end;
								 end);
		end;

		local function showItemPopup()
			local pop = self:findControlByName("popInv");
				
			if pop ~= nil then
				pop:setNodeObject(self.sheet);
				pop:showPopupEx("bottomCenter", self);
			else
				showMessage("Ops, bug.. nao encontrei o popup de arma para exibir");
			end;				
		end;

		local function weaponPrice()
			if sheet~= nil then
				local node = NDB.getRoot(sheet);
				local precoArmas = 0;
				local precoMochila = 0;
				local precoPreparado = 0;

				-- VESTIDO

				local nodes = NDB.getChildNodes(node.campoDasArmas); 
				for i=1, #nodes, 1 do
					precoArmas = precoArmas + (tonumber(nodes[i].preco) or 0);
				end
				node.precoArmas = precoArmas;

				-- MOCHILA

				local nodes = NDB.getChildNodes(node.campoMochila); 
				for i=1, #nodes, 1 do
					precoMochila = precoMochila + (tonumber(nodes[i].preco) or 0);
				end
				node.precoMochila = precoMochila;

				-- PREPARADOS

				local nodes = NDB.getChildNodes(node.campoPreparado); 
				for i=1, #nodes, 1 do
					precoPreparado = precoPreparado + (tonumber(nodes[i].preco) or 0);
				end
				node.precoPreparado = precoPreparado;
			end;
		end;

		local function weaponWeight()
			if sheet~= nil then
				local node = NDB.getRoot(sheet);
				local pesoArmas = 0;
				local pesoMochila = 0;
				local pesoPreparado = 0;

				-- VESTIDO

				local nodes = NDB.getChildNodes(node.campoDasArmas); 
				for i=1, #nodes, 1 do
					pesoArmas = pesoArmas + (tonumber(nodes[i].peso) or 0);
				end
				node.pesoArmas = pesoArmas;

				-- MOCHILA

				local nodes = NDB.getChildNodes(node.campoMochila); 
				for i=1, #nodes, 1 do
					pesoMochila = pesoMochila + (tonumber(nodes[i].peso) or 0);
				end
				node.pesoMochila = pesoMochila;

				-- PREPARADOS

				local nodes = NDB.getChildNodes(node.campoPreparado); 
				for i=1, #nodes, 1 do
					pesoPreparado = pesoPreparado + (tonumber(nodes[i].peso) or 0);
				end
				node.pesoPreparado = pesoPreparado;
			end;
		end;
		


    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj);
    obj.edit1:setLeft(0);
    obj.edit1:setTop(1);
    obj.edit1:setWidth(245);
    obj.edit1:setHeight(23);
    obj.edit1:setField("nome");
    obj.edit1:setName("edit1");

    obj.weaponWeightLabel = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.weaponWeightLabel:setParent(obj);
    obj.weaponWeightLabel:setLeft(245);
    obj.weaponWeightLabel:setTop(1);
    obj.weaponWeightLabel:setWidth(50);
    obj.weaponWeightLabel:setHeight(23);
    obj.weaponWeightLabel:setColor("black");
    obj.weaponWeightLabel:setStrokeColor("grey");
    obj.weaponWeightLabel:setStrokeSize(1);
    obj.weaponWeightLabel:setName("weaponWeightLabel");
    obj.weaponWeightLabel:setVisible(true);

    obj.label1 = GUI.fromHandle(_obj_newObject("label"));
    obj.label1:setParent(obj.weaponWeightLabel);
    obj.label1:setWidth(50);
    obj.label1:setHeight(23);
    obj.label1:setField("peso");
    obj.label1:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label1, "formatFloat",  ",0.## Vol");
    obj.label1:setName("label1");

    obj.weaponWeightEdit = GUI.fromHandle(_obj_newObject("edit"));
    obj.weaponWeightEdit:setParent(obj);
    obj.weaponWeightEdit:setLeft(245);
    obj.weaponWeightEdit:setTop(1);
    obj.weaponWeightEdit:setWidth(50);
    obj.weaponWeightEdit:setHeight(23);
    obj.weaponWeightEdit:setField("peso");
    obj.weaponWeightEdit:setType("float");
    obj.weaponWeightEdit:setName("weaponWeightEdit");
    obj.weaponWeightEdit:setVisible(false);

    obj.weaponPriceLabel = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.weaponPriceLabel:setParent(obj);
    obj.weaponPriceLabel:setLeft(295);
    obj.weaponPriceLabel:setTop(1);
    obj.weaponPriceLabel:setWidth(75);
    obj.weaponPriceLabel:setHeight(23);
    obj.weaponPriceLabel:setColor("black");
    obj.weaponPriceLabel:setStrokeColor("grey");
    obj.weaponPriceLabel:setStrokeSize(1);
    obj.weaponPriceLabel:setName("weaponPriceLabel");
    obj.weaponPriceLabel:setVisible(true);

    obj.label2 = GUI.fromHandle(_obj_newObject("label"));
    obj.label2:setParent(obj.weaponPriceLabel);
    obj.label2:setWidth(75);
    obj.label2:setHeight(23);
    obj.label2:setField("preco");
    obj.label2:setHorzTextAlign("center");
    lfm_setPropAsString(obj.label2, "formatFloat",  ",0.## PO");
    obj.label2:setName("label2");

    obj.weaponPriceEdit = GUI.fromHandle(_obj_newObject("edit"));
    obj.weaponPriceEdit:setParent(obj);
    obj.weaponPriceEdit:setLeft(295);
    obj.weaponPriceEdit:setTop(1);
    obj.weaponPriceEdit:setWidth(75);
    obj.weaponPriceEdit:setHeight(23);
    obj.weaponPriceEdit:setField("preco");
    obj.weaponPriceEdit:setType("float");
    obj.weaponPriceEdit:setName("weaponPriceEdit");
    obj.weaponPriceEdit:setVisible(false);

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj);
    obj.button1:setLeft(370);
    obj.button1:setTop(1);
    obj.button1:setWidth(23);
    obj.button1:setHeight(23);
    obj.button1:setText("i");
    obj.button1:setName("button1");

    obj.button2 = GUI.fromHandle(_obj_newObject("button"));
    obj.button2:setParent(obj);
    obj.button2:setLeft(395);
    obj.button2:setTop(1);
    obj.button2:setWidth(23);
    obj.button2:setHeight(23);
    obj.button2:setText("X");
    obj.button2:setName("button2");

    obj._e_event0 = obj.weaponWeightLabel:addEventListener("onClick",
        function (_)
            self.weaponWeightLabel.visible = false;
            			self.weaponWeightEdit.visible = true;
            			self.weaponWeightEdit:setFocus();
        end, obj);

    obj._e_event1 = obj.weaponWeightEdit:addEventListener("onUserChange",
        function (_)
            weaponWeight();
        end, obj);

    obj._e_event2 = obj.weaponWeightEdit:addEventListener("onExit",
        function (_)
            self.weaponWeightLabel.visible = true;
            			self.weaponWeightEdit.visible = false;
        end, obj);

    obj._e_event3 = obj.weaponPriceLabel:addEventListener("onClick",
        function (_)
            self.weaponPriceLabel.visible = false;
            			self.weaponPriceEdit.visible = true;
            			self.weaponPriceEdit:setFocus();
        end, obj);

    obj._e_event4 = obj.weaponPriceEdit:addEventListener("onUserChange",
        function (_)
            weaponPrice();
        end, obj);

    obj._e_event5 = obj.weaponPriceEdit:addEventListener("onExit",
        function (_)
            self.weaponPriceLabel.visible = true;
            			self.weaponPriceEdit.visible = false;
        end, obj);

    obj._e_event6 = obj.button1:addEventListener("onClick",
        function (_)
            showItemPopup();
        end, obj);

    obj._e_event7 = obj.button2:addEventListener("onClick",
        function (_)
            askForDelete();
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event7);
        __o_rrpgObjs.removeEventListenerById(self._e_event6);
        __o_rrpgObjs.removeEventListenerById(self._e_event5);
        __o_rrpgObjs.removeEventListenerById(self._e_event4);
        __o_rrpgObjs.removeEventListenerById(self._e_event3);
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.weaponPriceEdit ~= nil then self.weaponPriceEdit:destroy(); self.weaponPriceEdit = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.weaponPriceLabel ~= nil then self.weaponPriceLabel:destroy(); self.weaponPriceLabel = nil; end;
        if self.weaponWeightLabel ~= nil then self.weaponWeightLabel:destroy(); self.weaponWeightLabel = nil; end;
        if self.label1 ~= nil then self.label1:destroy(); self.label1 = nil; end;
        if self.weaponWeightEdit ~= nil then self.weaponWeightEdit:destroy(); self.weaponWeightEdit = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.button2 ~= nil then self.button2:destroy(); self.button2 = nil; end;
        if self.label2 ~= nil then self.label2:destroy(); self.label2 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmInventarioItem()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmInventarioItem();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmInventarioItem = {
    newEditor = newfrmInventarioItem, 
    new = newfrmInventarioItem, 
    name = "frmInventarioItem", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    title = "", 
    description=""};

frmInventarioItem = _frmInventarioItem;
Firecast.registrarForm(_frmInventarioItem);

return _frmInventarioItem;
