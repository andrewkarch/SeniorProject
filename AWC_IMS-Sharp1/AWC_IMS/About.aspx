<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="AWC_IMS.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
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
        <h2 id="pageTitle">About Anderson Widget Company</h2>
    </div>
    <div class="grid_8">
        <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer eleifend hendrerit sapien at lobortis. Cras ullamcorper ipsum non odio rutrum vel feugiat mi euismod. In pharetra tincidunt odio quis viverra. Cras libero felis, faucibus sed consectetur sit amet, laoreet eu nisl. Integer tortor tortor, ullamcorper eu tempor sed, dictum eu ligula. Nam posuere magna id urna elementum eu dictum nisl condimentum. Nunc luctus augue quis est ornare facilisis. Aenean convallis augue vitae tellus vehicula elementum. Ut sed urna in sem gravida pretium id egestas leo.
            <br></br>
            Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla facilisi. Aliquam hendrerit orci ut nisi viverra tincidunt. Donec justo urna, malesuada et sollicitudin sed, placerat sit amet nisl. Integer augue quam, fringilla vel rutrum at, feugiat at lacus. Donec dictum interdum sem, et auctor nibh dapibus ut. Pellentesque erat nisl, gravida at volutpat ac, scelerisque luctus velit.
            <br></br>
            Aliquam et risus ac arcu dapibus lacinia a sed lorem. Donec non mi ornare mauris eleifend faucibus quis quis nibh. Quisque scelerisque, elit imperdiet pretium porttitor, massa augue pellentesque ante, vitae rhoncus metus nunc quis nulla. Nullam quis urna id nibh pharetra gravida ac vel neque. Nam fermentum erat a eros sagittis eleifend. Maecenas risus est, auctor non pellentesque in, aliquet eu elit. Aenean elementum accumsan nisl, nec ullamcorper elit rutrum nec. Integer eu sem odio. In pretium magna tempus massa dignissim et facilisis tellus accumsan. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
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
