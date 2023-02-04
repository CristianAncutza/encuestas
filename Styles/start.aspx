<%@ Page Language="C#" %>

<!DOCTYPE html>

<SCRIPT runat="server">
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
        }
    }

</SCRIPT>

<link href="Styles/start.css" rel="stylesheet" />

<h2>Without Default Selection</h2>

<form id="form1" runat="server">

<div class="acidjs-rating-stars">
<input type="radio" name="group-1" id="group-1-0" value="5" /><label for="group-1-0"></label>
<input type="radio" name="group-1" id="group-1-1" value="4" /><label for="group-1-1"></label>
<input type="radio" name="group-1" id="group-1-2" value="3" /><label for="group-1-2"></label>
<input type="radio" name="group-1" id="group-1-3" value="2" /><label for="group-1-3"></label>
<input type="radio" name="group-1" id="group-1-4" value="1 "/><label for="group-1-4"></label>
</div>
 
<h2>With Default Selection</h2>
 
<div class="acidjs-rating-stars">

        <input type="radio" name="group-2" id="group-2-0" value="5" /><label for="group-2-0"></label><!--
        --><input type="radio" name="group-2" id="group-2-1" value="4" /><label for="group-2-1"></label><!--
        --><input type="radio" checked="checked" name="group-2" id="group-2-2" value="3" /><label for="group-2-2"></label><!--
        --><input type="radio" name="group-2" id="group-2-3" value="2" /><label for="group-2-3"></label><!--
        --><input type="radio" name="group-2" id="group-2-4"  value="1" /><label for="group-2-4"></label>

</div>
 
<h2>Disabled</h2>
 
<div class="acidjs-rating-stars acidjs-rating-disabled">
 
        <input disabled="disabled" type="radio" name="group-3" id="group-3-0" value="5" /><label for="group-3-0"></label><!--
        --><input disabled="disabled" type="radio" checked="checked" name="group-3" id="group-3-1" value="4" /><label for="group-3-1"></label><!--
        --><input disabled="disabled" type="radio" name="group-3" id="group-3-2" value="3" /><label for="group-3-2"></label><!--
        --><input disabled="disabled" type="radio" name="group-3" id="group-3-3" value="2" /><label for="group-3-3"></label><!--
        --><input disabled="disabled" type="radio" name="group-3" id="group-3-4"  value="1" /><label for="group-3-4"></label>
  
</div>
    <asp:button runat="server" text="Button" />
</form>