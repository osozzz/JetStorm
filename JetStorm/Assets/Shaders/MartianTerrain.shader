Shader "Custom/PlanetSmoothCraters"
{
    Properties
    {
        _ColorA("Primary Tone", Color) = (0.1, 0.13, 0.18, 1)   // gris azulado oscuro
        _ColorB("Secondary Tone", Color) = (0.07, 0.09, 0.12, 1) // gris más oscuro
        _NoiseScale("Noise Scale", Range(50, 200)) = 120
        _Smoothness("Blend Smoothness", Range(0, 1)) = 0.3
    }

    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _ColorA;
            float4 _ColorB;
            float _NoiseScale;
            float _Smoothness;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float hash(float2 p)
            {
                return frac(sin(dot(p, float2(12.9898,78.233))) * 43758.5453);
            }

            float noise(float2 uv)
            {
                float2 i = floor(uv);
                float2 f = frac(uv);
                float a = hash(i);
                float b = hash(i + float2(1,0));
                float c = hash(i + float2(0,1));
                float d = hash(i + float2(1,1));
                float2 u = f * f * (3.0 - 2.0 * f);
                return lerp(lerp(a,b,u.x), lerp(c,d,u.x), u.y);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv * _NoiseScale;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float n = noise(i.uv);
                float blend = smoothstep(0.4 - _Smoothness, 0.6 + _Smoothness, n);
                return lerp(_ColorA, _ColorB, blend);
            }
            ENDCG
        }
    }
}
