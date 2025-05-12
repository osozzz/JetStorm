Shader "Custom/TextPulseGlow"
{
    Properties
    {
        _Color ("Text Color", Color) = (0.4, 0.6, 1.0, 1)
        _GlowPower ("Glow Intensity", Range(0, 1)) = 0.5
        _Speed ("Pulse Speed", Range(0, 5)) = 1
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
        Lighting Off
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            fixed4 _Color;
            float _GlowPower;
            float _Speed;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float pulse = sin(_Time.y * _Speed) * 0.5 + 0.5;
                return _Color * (1.0 + pulse * _GlowPower);
            }
            ENDCG
        }
    }
}
