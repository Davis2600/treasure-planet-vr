// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PieceTesselation"
{
	Properties
	{
		_Pieces__BC("Pieces__BC", 2D) = "white" {}
		_Pieces__H("Pieces__H", 2D) = "white" {}
		_Pieces__M("Pieces__M", 2D) = "white" {}
		_Pieces__N("Pieces__N", 2D) = "bump" {}
		_Pieces__AO("Pieces__AO", 2D) = "white" {}
		_HeightControl("HeightControl", Range( 0 , 10)) = 1
		_TessControl("TessControl", Range( 0 , 200)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Pieces__H;
		uniform float4 _Pieces__H_ST;
		uniform float _HeightControl;
		uniform sampler2D _Pieces__N;
		uniform float4 _Pieces__N_ST;
		uniform sampler2D _Pieces__BC;
		uniform float4 _Pieces__BC_ST;
		uniform sampler2D _Pieces__M;
		uniform float4 _Pieces__M_ST;
		uniform sampler2D _Pieces__AO;
		uniform float4 _Pieces__AO_ST;
		uniform float _TessControl;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_0 = (_TessControl).xxxx;
			return temp_cast_0;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 uv_Pieces__H = v.texcoord * _Pieces__H_ST.xy + _Pieces__H_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2Dlod( _Pieces__H, float4( uv_Pieces__H, 0, 0.0) ).r * _HeightControl ) * ase_vertexNormal );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Pieces__N = i.uv_texcoord * _Pieces__N_ST.xy + _Pieces__N_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Pieces__N, uv_Pieces__N ) );
			float2 uv_Pieces__BC = i.uv_texcoord * _Pieces__BC_ST.xy + _Pieces__BC_ST.zw;
			o.Albedo = tex2D( _Pieces__BC, uv_Pieces__BC ).rgb;
			float2 uv_Pieces__M = i.uv_texcoord * _Pieces__M_ST.xy + _Pieces__M_ST.zw;
			float4 tex2DNode25 = tex2D( _Pieces__M, uv_Pieces__M );
			o.Metallic = tex2DNode25.r;
			o.Smoothness = tex2DNode25.a;
			float2 uv_Pieces__AO = i.uv_texcoord * _Pieces__AO_ST.xy + _Pieces__AO_ST.zw;
			o.Occlusion = tex2D( _Pieces__AO, uv_Pieces__AO ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
2017;116;1348;970;1072.599;1.21582;1;True;False
Node;AmplifyShaderEditor.SamplerNode;24;-800.0999,165.1851;Float;True;Property;_Pieces__H;Pieces__H;1;0;Create;True;0;0;False;0;1e12e683dc957b44089677cd1c00f609;1e12e683dc957b44089677cd1c00f609;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-386.5987,665.7842;Float;False;Property;_HeightControl;HeightControl;5;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;30;-453.5986,794.7842;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-165.5987,561.7842;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-711.0999,-57.81488;Float;True;Property;_Pieces__M;Pieces__M;2;0;Create;True;0;0;False;0;51c34047223acd54792799f1707b9de0;51c34047223acd54792799f1707b9de0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-486.0999,-255.8149;Float;True;Property;_Pieces__BC;Pieces__BC;0;0;Create;True;0;0;False;0;f1aa2726dc06d164e9997a54a2ba9f2d;f1aa2726dc06d164e9997a54a2ba9f2d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-554.0999,380.1851;Float;True;Property;_Pieces__N;Pieces__N;3;0;Create;True;0;0;False;0;ffaac4a419085064b823efd3fc8fcc55;ffaac4a419085064b823efd3fc8fcc55;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-856.0999,373.1851;Float;True;Property;_Pieces__AO;Pieces__AO;4;0;Create;True;0;0;False;0;aacfdaf4d18a3224ea894810e0204c52;aacfdaf4d18a3224ea894810e0204c52;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;24.40137,608.7842;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-298.5986,408.7842;Float;False;Property;_TessControl;TessControl;6;0;Create;True;0;0;False;0;0;0;0;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1,-1;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;PieceTesselation;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;24;1
WireConnection;28;1;29;0
WireConnection;31;0;28;0
WireConnection;31;1;30;0
WireConnection;0;0;23;0
WireConnection;0;1;26;0
WireConnection;0;3;25;0
WireConnection;0;4;25;4
WireConnection;0;5;27;0
WireConnection;0;11;31;0
WireConnection;0;14;32;0
ASEEND*/
//CHKSM=363C2FED4114D7DDC1F03DBACEDE74B28849ED69