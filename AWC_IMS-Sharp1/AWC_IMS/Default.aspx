<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.cs" Inherits="AWC_IMS._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="fb-root"></div>
    <script type="text/javascript">
        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
            fjs.parentNode.insertBefore(js, fjs);
        } (document, 'script', 'facebook-jssdk'));
    </script>
    <div class="grid_12">
        <h2 id="pageTitle">Welcome to Anderson Widget Company!</h2>
    </div>
    <div class="grid_8">
        <p>&nbsp;</p>
        <p>Visit our <a href="Catalog.aspx">Product Catalog</a> to being shopping online!</p>
        <p>&nbsp;</p>
        <p>If you do not have an account, please <a href="Contact.aspx">contact</a> your AWC sales representative to get started.</p>
    </div>
    <div class="grid_4">
        <p>Like our products and customer service?</p>
        <p>Give us a +1 and Like us on Facebook!</p>
		<div class="social">
			<div class="g-plusone" data-size="standard" data-href="http://www.newegg.com/"></div>
			<script type="text/javascript">
			    (function () {
			        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
			        po.src = 'https://apis.google.com/js/plusone.js';
			        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
			    })();
			</script>
		</div>
		<div class="social">
            <div class="fb-like" data-href="http://www.newegg.com" data-send="false" data-layout="button_count" data-width="" data-show-faces="true"></div>
		</div>
	</div>
    <div class="clear"></div>
</asp:Content>
