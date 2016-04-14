Shader "Hidden/MrtTest"
{
    Properties
    {
        _MainTex("", 2D) = "white"{}
        _SecondTex("", 2D) = "white"{}
        _ThirdTex("", 2D) = "white"{}
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    sampler2D _MainTex;
    sampler2D _SecondTex;
    sampler2D _ThirdTex;

    // MRT shader
    struct FragmentOutput
    {
        half4 dest0 : SV_Target0;
        half4 dest1 : SV_Target1;
    };

    FragmentOutput frag_mrt(v2f_img i) : SV_Target
    {
        FragmentOutput o;
        o.dest0 = frac(i.uv.x * 10);
        o.dest1 = frac(i.uv.y * 10);
        return o;
    }

    // Simple combiner
    half4 frag_combine(v2f_img i) : SV_Target
    {
        half4 t1 = tex2D(_MainTex, i.uv);
        half4 t2 = tex2D(_SecondTex, i.uv);
        half4 t3 = tex2D(_ThirdTex, i.uv);
        return half4(t1.r, t2.g, t3.b, 1);
    }

    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_mrt
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_combine
            ENDCG
        }
    }
}
