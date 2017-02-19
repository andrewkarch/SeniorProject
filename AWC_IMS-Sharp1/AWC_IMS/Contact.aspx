<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="AWC_IMS.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
        <h2 id="pageTitle">Contact Us Today!</h2>
    </div>
    <div class="grid_8">
        <p>
           Anderson Widget Company
           <br />
           8600 University Boulevard
           <br />
           Evansville, Indiana 47712
           <br />
           Phone 1-888-888-8888
        </p>
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
