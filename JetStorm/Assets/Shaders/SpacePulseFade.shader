Shader "Custom/SpacePulseFade"
{
    Properties
    {
        _Color ("Text Color", Color) = (0.4, 0.7, 1, 1)
        _PulseStrength ("Pulse Strength", Range(0, 1)) = 0.3
        _FadeTime ("Fade Time", Range(0, 10)) = 3
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        Cull Off
        Lighting Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            fixed4 _Color;
            float _PulseStrength;
            float _FadeTime;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float pulse = sin(_Time.y * 3.0) * 0.5 + 0.5;
                float fade = saturate(1.0 - (_Time.y / _FadeTime));
                float finalAlpha = fade * (1.0 + pulse * _PulseStrength);
                return _Color * finalAlpha;
            }
            ENDCG
        }
    }
}
