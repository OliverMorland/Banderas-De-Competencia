Shader "Oliver/FlutteringFlag"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ZCurveAmp ("Z Curve Amplitude", Range(-5, 5)) = 1
        _ZCurvature("Z Curvature", Range(-5, 5)) = 1
        _XWaveSpeed ("X Wave Speed", Range(1, 100)) = 5
        _XWaveFreq ("X Wave Frequency", Range(0, 3)) = 1
        _expMult ("Exponent Multiplier", Range(0.01, 1)) = 1
    }
    SubShader
    {
        cull off

        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ZCurveAmp;
            float _ZCurvature;
            float _XWaveSpeed;
            float _XWaveFreq;
            float _expMult;
            

            v2f vert (appdata v)
            {
                float zCurve = cos(v.vertex.z * _ZCurvature) * _ZCurveAmp;
                float xWave = sin((v.vertex.x + (_Time * _XWaveSpeed)) * _XWaveFreq) * exp(-v.vertex.x * _expMult);
                v.vertex += float4(0, zCurve + xWave, 0, 1);
                
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
