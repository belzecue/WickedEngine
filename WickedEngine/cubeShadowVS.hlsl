#include "globals.hlsli"
#include "objectInputLayoutHF.hlsli"

struct VertexOut
{
	float4 pos		: SV_POSITION;
#ifdef VPRT_EMULATION
	uint RTIndex	: RTINDEX;
#else
	uint RTIndex	: SV_RenderTargetArrayIndex;
#endif // VPRT_EMULATION
};

VertexOut main(Input_Object_POS input)
{
	VertexOut output;

	float4x4 WORLD = MakeWorldMatrixFromInstance(input.inst);

	VertexSurface surface;
	surface.create(g_xMaterial, input);

	uint frustum_index = input.inst.userdata.y;
	output.RTIndex = xCubemapRenderCams[frustum_index].properties.x;
	output.pos = mul(xCubemapRenderCams[frustum_index].VP, mul(WORLD, surface.position));

	return output;
}
