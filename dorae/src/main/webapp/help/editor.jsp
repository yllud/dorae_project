<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.ckeditor.com/ckeditor5/37.1.0/decoupled-document/ckeditor.js"></script>
</head>
<body>
	<h1>Document editor</h1>

	<!-- The toolbar will be rendered in this container. -->
	<div id="toolbar-container"></div>

	<!-- This container will become the editable. -->
	<div id="editor">
		<p>This is the initial editor content.</p>
	</div>

	<script>
        DecoupledEditor
            .create( document.querySelector( '#editor' ) )
            .then( editor => {
                const toolbarContainer = document.querySelector( '#toolbar-container' );

                toolbarContainer.appendChild( editor.ui.view.toolbar.element );
            } )
            .catch( error => {
                console.error( error );
            } );
    </script>
</body>
</html>