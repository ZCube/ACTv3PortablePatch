.class private auto ansi beforefieldinit System.EnvironmentMod
	extends [mscorlib]System.Object
{
	// Methods
	.method public hidebysig static 
		string GetFolderPath (
			valuetype [mscorlib]System.Environment/SpecialFolder folder
		) cil managed 
	{
		// Method begins at RVA 0x3d1c
		// Code size 128 (0x80)
		.maxstack 2
		.locals init (
			[0] string,
			[1] valuetype [mscorlib]System.Environment/SpecialFolder,
			[2] string,
			[3] string,
			[4] bool,
			[5] string
		)

		IL_0000: nop
		IL_0001: ldarg.0
		IL_0002: call string [mscorlib]System.Environment::GetFolderPath(valuetype [mscorlib]System.Environment/SpecialFolder)
		IL_0007: stloc.0
		IL_0008: ldarg.0
		IL_0009: stloc.1
		IL_000a: ldloc.1
		IL_000b: ldc.i4.s 16
		IL_000d: bgt.s IL_001d

		IL_000f: ldloc.1
		IL_0010: ldc.i4.s 13
		IL_0012: beq.s IL_006d

		IL_0014: br.s IL_0016

		IL_0016: ldloc.1
		IL_0017: ldc.i4.s 16
		IL_0019: beq.s IL_006f

		IL_001b: br.s IL_0073

		IL_001d: ldloc.1
		IL_001e: ldc.i4.s 26
		IL_0020: beq.s IL_0032

		IL_0022: br.s IL_0024

		IL_0024: ldloc.1
		IL_0025: ldc.i4.s 35
		IL_0027: beq.s IL_0071

		IL_0029: br.s IL_002b

		IL_002b: ldloc.1
		IL_002c: ldc.i4.s 37
		IL_002e: beq.s IL_006b

		IL_0030: br.s IL_0073

		IL_0032: call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
		IL_0037: callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
		IL_003c: stloc.2
		IL_003d: ldloc.2
		IL_003e: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
		IL_0043: ldstr "/AppData"
		IL_0048: call string [mscorlib]System.String::Concat(string, string)
		IL_004d: stloc.3
		IL_004e: ldloc.3
		IL_004f: call bool [mscorlib]System.IO.Directory::Exists(string)
		IL_0054: ldc.i4.0
		IL_0055: ceq
		IL_0057: stloc.s 4
		IL_0059: ldloc.s 4
		IL_005b: brfalse.s IL_0066

		IL_005d: nop
		IL_005e: ldloc.3
		IL_005f: call class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.Directory::CreateDirectory(string)
		IL_0064: pop
		IL_0065: nop

		IL_0066: ldloc.3
		IL_0067: stloc.s 5
		IL_0069: br.s IL_007d

		IL_006b: br.s IL_0073

		IL_006d: br.s IL_0073

		IL_006f: br.s IL_0073

		IL_0071: br.s IL_0073

		IL_0073: ldarg.0
		IL_0074: call string [mscorlib]System.Environment::GetFolderPath(valuetype [mscorlib]System.Environment/SpecialFolder)
		IL_0079: stloc.s 5
		IL_007b: br.s IL_007d

		IL_007d: ldloc.s 5
		IL_007f: ret
	} // end of method EnvironmentMod::GetFolderPath

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x33a1
		// Code size 8 (0x8)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: call instance void [mscorlib]System.Object::.ctor()
		IL_0006: nop
		IL_0007: ret
	} // end of method EnvironmentMod::.ctor

} // end of class System.EnvironmentMod
