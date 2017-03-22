

.method public hidebysig static 
	string GetFolderPath (
		valuetype [mscorlib]System.Environment/SpecialFolder folder
	) cil managed 
{
	// Method begins at RVA 0x2688
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
} // end of method Program::GetFolderPath

.method assembly hidebysig 
	instance void _LoadNewSettings (
		string XmlFileName
	) cil managed 
{
	// Method begins at RVA 0x2bc0
	// Code size 38 (0x26)
	.maxstack 3
	.locals init (
		[0] class [System.Xml]System.Xml.XmlTextReader
	)

	IL_0000: nop
	IL_0001: ldarg.0
	IL_0002: ldarg.1
	IL_0003: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
	IL_0008: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
	IL_000d: call instance string GetExePath.Program::ChangeDirNameToPath(string)
	IL_0012: newobj instance void [mscorlib]System.IO.StringReader::.ctor(string)
	IL_0017: newobj instance void [System.Xml]System.Xml.XmlTextReader::.ctor(class [mscorlib]System.IO.TextReader)
	IL_001c: stloc.0
	IL_001d: ldarg.0
	IL_001e: ldloc.0
	IL_001f: call instance void GetExePath.Program::LoadNewSettings(class [System.Xml]System.Xml.XmlTextReader)
	IL_0024: nop
	IL_0025: ret
} // end of method Program::_LoadNewSettings


.method assembly hidebysig 
	instance void _SaveNewSettings (
		string XmlFileName
	) cil managed 
{
	// Method begins at RVA 0x2870
	// Code size 927 (0x39f)
	.maxstack 8
	.locals init (
		[0] class [System]System.Diagnostics.Stopwatch,
		[1] class [System.Xml]System.Xml.XmlTextWriter,
		[2] bool,
		[3] class [mscorlib]System.IO.FileInfo,
		[4] class [mscorlib]System.IO.FileInfo,
		[5] bool,
		[6] class [mscorlib]System.IO.FileInfo,
		[7] class [mscorlib]System.IO.FileInfo[],
		[8] int32,
		[9] valuetype [mscorlib]System.DateTime,
		[10] int32,
		[11] bool,
		[12] bool,
		[13] bool,
		[14] class [mscorlib]System.IO.FileInfo,
		[15] bool,
		[16] bool,
		[17] bool,
		[18] class [mscorlib]System.Exception,
		[19] bool,
		[20] class [mscorlib]System.Exception
	)

	IL_0000: nop
	.try
	{
		IL_0001: nop
		IL_0002: newobj instance void [System]System.Diagnostics.Stopwatch::.ctor()
		IL_0007: stloc.0
		IL_0008: ldarg.0
		IL_0009: ldfld bool GetExePath.Program::finalizeOnce
		IL_000e: brtrue.s IL_0018

		IL_0010: ldarg.0
		IL_0011: ldfld bool GetExePath.Program::debugLogEnabled
		IL_0016: br.s IL_0019

		IL_0018: ldc.i4.1

		IL_0019: stloc.2
		IL_001a: ldloc.2
		IL_001b: brfalse.s IL_0032

		IL_001d: nop
		IL_001e: ldloc.0
		IL_001f: callvirt instance void [System]System.Diagnostics.Stopwatch::Start()
		IL_0024: nop
		IL_0025: ldarg.0
		IL_0026: ldstr "Entering SaveNewSettings"
		IL_002b: call instance void GetExePath.Program::WriteInfoLog(string)
		IL_0030: nop
		IL_0031: nop

		IL_0032: ldarg.1
		IL_0033: ldstr ".tmp"
		IL_0038: call string [mscorlib]System.String::Concat(string, string)
		IL_003d: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
		IL_0042: newobj instance void [System.Xml]System.Xml.XmlTextWriter::.ctor(string, class [mscorlib]System.Text.Encoding)
		IL_0047: stloc.1
		IL_0048: ldloc.1
		IL_0049: ldc.i4.1
		IL_004a: callvirt instance void [System.Xml]System.Xml.XmlTextWriter::set_Formatting(valuetype [System.Xml]System.Xml.Formatting)
		IL_004f: nop
		IL_0050: ldloc.1
		IL_0051: ldc.i4.4
		IL_0052: callvirt instance void [System.Xml]System.Xml.XmlTextWriter::set_Indentation(int32)
		IL_0057: nop
		IL_0058: ldloc.1
		IL_0059: ldc.i4.0
		IL_005a: callvirt instance void [System.Xml]System.Xml.XmlTextWriter::set_Namespaces(bool)
		IL_005f: nop
		IL_0060: ldloc.1
		IL_0061: callvirt instance void [System.Xml]System.Xml.XmlWriter::WriteStartDocument()
		IL_0066: nop
		IL_0067: ldloc.1
		IL_0068: ldstr "Config"
		IL_006d: callvirt instance void [System.Xml]System.Xml.XmlWriter::WriteStartElement(string)
		IL_0072: nop
		IL_0073: ldarg.0
		IL_0074: ldloc.1
		IL_0075: call instance void GetExePath.Program::SaveXmlSettingsSerializer(class [System.Xml]System.Xml.XmlTextWriter)
		IL_007a: nop
		IL_007b: ldarg.0
		IL_007c: ldloc.1
		IL_007d: call instance void GetExePath.Program::SaveXmlSParseList(class [System.Xml]System.Xml.XmlTextWriter)
		IL_0082: nop
		IL_0083: ldarg.0
		IL_0084: ldloc.1
		IL_0085: call instance void GetExePath.Program::SaveXmlTextFormats(class [System.Xml]System.Xml.XmlTextWriter)
		IL_008a: nop
		IL_008b: ldarg.0
		IL_008c: ldloc.1
		IL_008d: call instance void GetExePath.Program::SaveXmlMacroExports(class [System.Xml]System.Xml.XmlTextWriter)
		IL_0092: nop
		IL_0093: ldarg.0
		IL_0094: ldloc.1
		IL_0095: call instance void GetExePath.Program::SaveXmlCustomTriggers(class [System.Xml]System.Xml.XmlTextWriter)
		IL_009a: nop
		IL_009b: ldarg.0
		IL_009c: ldloc.1
		IL_009d: ldc.i4.1
		IL_009e: ldc.i4.1
		IL_009f: call instance void GetExePath.Program::SaveXmlSpellTimers(class [System.Xml]System.Xml.XmlTextWriter, bool, bool)
		IL_00a4: nop
		IL_00a5: ldarg.0
		IL_00a6: ldloc.1
		IL_00a7: call instance void GetExePath.Program::SaveXmlTimerWhiteList(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00ac: nop
		IL_00ad: ldarg.0
		IL_00ae: ldloc.1
		IL_00af: call instance void GetExePath.Program::SaveXmlRenameFix(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00b4: nop
		IL_00b5: ldarg.0
		IL_00b6: ldloc.1
		IL_00b7: call instance void GetExePath.Program::SaveXmlAbilityRedirectFix(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00bc: nop
		IL_00bd: ldarg.0
		IL_00be: ldloc.1
		IL_00bf: call instance void GetExePath.Program::SaveXmlOdbcHacks(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00c4: nop
		IL_00c5: ldarg.0
		IL_00c6: ldloc.1
		IL_00c7: call instance void GetExePath.Program::SaveXmlActPlugins(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00cc: nop
		IL_00cd: ldarg.0
		IL_00ce: ldloc.1
		IL_00cf: call instance void GetExePath.Program::SaveXmlXmlSubs(class [System.Xml]System.Xml.XmlTextWriter)
		IL_00d4: nop
		IL_00d5: ldloc.1
		IL_00d6: callvirt instance void [System.Xml]System.Xml.XmlWriter::WriteEndElement()
		IL_00db: nop
		IL_00dc: ldloc.1
		IL_00dd: callvirt instance void [System.Xml]System.Xml.XmlWriter::Flush()
		IL_00e2: nop
		IL_00e3: ldloc.1
		IL_00e4: callvirt instance void [System.Xml]System.Xml.XmlWriter::Close()
		IL_00e9: nop
		IL_00ea: ldarg.1
		IL_00eb: ldstr ".tmp"
		IL_00f0: call string [mscorlib]System.String::Concat(string, string)
		IL_00f5: ldarg.0
		IL_00f6: ldarg.1
		IL_00f7: ldstr ".tmp"
		IL_00fc: call string [mscorlib]System.String::Concat(string, string)
		IL_0101: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
		IL_0106: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
		IL_010b: call instance string GetExePath.Program::ChangeDirNameToVar(string)
		IL_0110: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
		IL_0115: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
		IL_011a: nop
		.try
		{
			IL_011b: nop
			IL_011c: ldarg.1
			IL_011d: ldstr ".tmp"
			IL_0122: call string [mscorlib]System.String::Concat(string, string)
			IL_0127: newobj instance void [mscorlib]System.IO.FileInfo::.ctor(string)
			IL_012c: stloc.3
			IL_012d: ldarg.1
			IL_012e: newobj instance void [mscorlib]System.IO.FileInfo::.ctor(string)
			IL_0133: stloc.s 4
			IL_0135: newobj instance void [System.Xml]System.Xml.XmlDocument::.ctor()
			IL_013a: ldloc.3
			IL_013b: callvirt instance string [mscorlib]System.IO.FileSystemInfo::get_FullName()
			IL_0140: callvirt instance void [System.Xml]System.Xml.XmlDocument::Load(string)
			IL_0145: nop
			IL_0146: ldarg.0
			IL_0147: ldfld bool GetExePath.Program::finalizeOnce
			IL_014c: stloc.s 5
			IL_014e: ldloc.s 5
			IL_0150: brfalse IL_0315

			IL_0155: nop
			IL_0156: ldloc.s 4
			IL_0158: callvirt instance string [mscorlib]System.IO.FileInfo::get_DirectoryName()
			IL_015d: ldstr "Backup"
			IL_0162: ldarg.1
			IL_0163: call string [mscorlib]System.IO.Path::GetFileNameWithoutExtension(string)
			IL_0168: ldstr ".{0:0000}{1:00}{2:00}{3:00}{4:00}{5:00}.xml"
			IL_016d: ldc.i4.6
			IL_016e: newarr [mscorlib]System.Object
			IL_0173: dup
			IL_0174: ldc.i4.0
			IL_0175: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_017a: stloc.s 9
			IL_017c: ldloca.s 9
			IL_017e: call instance int32 [mscorlib]System.DateTime::get_Year()
			IL_0183: box [mscorlib]System.Int32
			IL_0188: stelem.ref
			IL_0189: dup
			IL_018a: ldc.i4.1
			IL_018b: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_0190: stloc.s 9
			IL_0192: ldloca.s 9
			IL_0194: call instance int32 [mscorlib]System.DateTime::get_Month()
			IL_0199: box [mscorlib]System.Int32
			IL_019e: stelem.ref
			IL_019f: dup
			IL_01a0: ldc.i4.2
			IL_01a1: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_01a6: stloc.s 9
			IL_01a8: ldloca.s 9
			IL_01aa: call instance int32 [mscorlib]System.DateTime::get_Day()
			IL_01af: box [mscorlib]System.Int32
			IL_01b4: stelem.ref
			IL_01b5: dup
			IL_01b6: ldc.i4.3
			IL_01b7: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_01bc: stloc.s 9
			IL_01be: ldloca.s 9
			IL_01c0: call instance int32 [mscorlib]System.DateTime::get_Hour()
			IL_01c5: box [mscorlib]System.Int32
			IL_01ca: stelem.ref
			IL_01cb: dup
			IL_01cc: ldc.i4.4
			IL_01cd: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_01d2: stloc.s 9
			IL_01d4: ldloca.s 9
			IL_01d6: call instance int32 [mscorlib]System.DateTime::get_Minute()
			IL_01db: box [mscorlib]System.Int32
			IL_01e0: stelem.ref
			IL_01e1: dup
			IL_01e2: ldc.i4.5
			IL_01e3: call valuetype [mscorlib]System.DateTime [mscorlib]System.DateTime::get_Now()
			IL_01e8: stloc.s 9
			IL_01ea: ldloca.s 9
			IL_01ec: call instance int32 [mscorlib]System.DateTime::get_Second()
			IL_01f1: box [mscorlib]System.Int32
			IL_01f6: stelem.ref
			IL_01f7: call string [mscorlib]System.String::Format(string, object[])
			IL_01fc: call string [mscorlib]System.String::Concat(string, string)
			IL_0201: call string [mscorlib]System.IO.Path::Combine(string, string, string)
			IL_0206: newobj instance void [mscorlib]System.IO.FileInfo::.ctor(string)
			IL_020b: stloc.s 6
			IL_020d: ldloc.s 6
			IL_020f: callvirt instance class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.FileInfo::get_Directory()
			IL_0214: ldloc.s 4
			IL_0216: callvirt instance string [mscorlib]System.IO.FileSystemInfo::get_Name()
			IL_021b: call string [mscorlib]System.IO.Path::GetFileNameWithoutExtension(string)
			IL_0220: ldstr ".*.xml"
			IL_0225: call string [mscorlib]System.String::Concat(string, string)
			IL_022a: callvirt instance class [mscorlib]System.IO.FileInfo[] [mscorlib]System.IO.DirectoryInfo::GetFiles(string)
			IL_022f: stloc.s 7
			IL_0231: ldc.i4.0
			IL_0232: stloc.s 8
			IL_0234: ldloc.s 7
			IL_0236: ldlen
			IL_0237: conv.i4
			IL_0238: ldc.i4.1
			IL_0239: sub
			IL_023a: stloc.s 10
			IL_023c: br.s IL_026e
			// loop start (head: IL_026e)
				IL_023e: nop
				IL_023f: ldloc.s 8
				IL_0241: ldc.i4.1
				IL_0242: add
				IL_0243: stloc.s 8
				.try
				{
					IL_0245: nop
					IL_0246: ldloc.s 8
					IL_0248: ldc.i4.s 9
					IL_024a: cgt
					IL_024c: stloc.s 11
					IL_024e: ldloc.s 11
					IL_0250: brfalse.s IL_025f

					IL_0252: nop
					IL_0253: ldloc.s 7
					IL_0255: ldloc.s 10
					IL_0257: ldelem.ref
					IL_0258: callvirt instance void [mscorlib]System.IO.FileSystemInfo::Delete()
					IL_025d: nop
					IL_025e: nop

					IL_025f: nop
					IL_0260: leave.s IL_0267
				} // end .try
				catch [mscorlib]System.Object
				{
					IL_0262: pop
					IL_0263: nop
					IL_0264: nop
					IL_0265: leave.s IL_0267
				} // end handler

				IL_0267: nop
				IL_0268: ldloc.s 10
				IL_026a: ldc.i4.1
				IL_026b: sub
				IL_026c: stloc.s 10

				IL_026e: ldloc.s 10
				IL_0270: ldc.i4.0
				IL_0271: clt
				IL_0273: ldc.i4.0
				IL_0274: ceq
				IL_0276: stloc.s 12
				IL_0278: ldloc.s 12
				IL_027a: brtrue.s IL_023e
			// end loop

			IL_027c: ldloc.s 4
			IL_027e: callvirt instance bool [mscorlib]System.IO.FileSystemInfo::get_Exists()
			IL_0283: stloc.s 13
			IL_0285: ldloc.s 13
			IL_0287: brfalse IL_0312

			IL_028c: nop
			IL_028d: ldarg.1
			IL_028e: ldstr "_"
			IL_0293: call string [mscorlib]System.String::Concat(string, string)
			IL_0298: newobj instance void [mscorlib]System.IO.FileInfo::.ctor(string)
			IL_029d: stloc.s 14
			IL_029f: ldloc.s 14
			IL_02a1: callvirt instance bool [mscorlib]System.IO.FileSystemInfo::get_Exists()
			IL_02a6: stloc.s 15
			IL_02a8: ldloc.s 15
			IL_02aa: brfalse.s IL_02c7

			IL_02ac: nop
			IL_02ad: ldloc.s 14
			IL_02af: ldloc.s 6
			IL_02b1: callvirt instance string [mscorlib]System.IO.FileSystemInfo::get_FullName()
			IL_02b6: callvirt instance void [mscorlib]System.IO.FileInfo::MoveTo(string)
			IL_02bb: nop
			IL_02bc: ldloc.s 4
			IL_02be: callvirt instance void [mscorlib]System.IO.FileSystemInfo::Delete()
			IL_02c3: nop
			IL_02c4: nop
			IL_02c5: br.s IL_0311

			IL_02c7: nop
			IL_02c8: ldloc.s 6
			IL_02ca: callvirt instance string [mscorlib]System.IO.FileSystemInfo::get_FullName()
			IL_02cf: ldarg.0
			IL_02d0: ldloc.s 4
			IL_02d2: callvirt instance string [mscorlib]System.IO.FileSystemInfo::get_FullName()
			IL_02d7: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_02dc: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
			IL_02e1: call instance string GetExePath.Program::ChangeDirNameToVar(string)
			IL_02e6: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_02eb: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
			IL_02f0: nop
			IL_02f1: ldloc.s 4
			IL_02f3: callvirt instance void [mscorlib]System.IO.FileSystemInfo::Delete()
			IL_02f8: nop
			IL_02f9: ldloc.s 14
			IL_02fb: callvirt instance bool [mscorlib]System.IO.FileSystemInfo::get_Exists()
			IL_0300: stloc.s 16
			IL_0302: ldloc.s 16
			IL_0304: brfalse.s IL_0310

			IL_0306: nop
			IL_0307: ldloc.s 14
			IL_0309: callvirt instance void [mscorlib]System.IO.FileSystemInfo::Delete()
			IL_030e: nop
			IL_030f: nop

			IL_0310: nop

			IL_0311: nop

			IL_0312: nop
			IL_0313: br.s IL_032c

			IL_0315: ldloc.s 4
			IL_0317: callvirt instance bool [mscorlib]System.IO.FileSystemInfo::get_Exists()
			IL_031c: stloc.s 17
			IL_031e: ldloc.s 17
			IL_0320: brfalse.s IL_032c

			IL_0322: nop
			IL_0323: ldloc.s 4
			IL_0325: callvirt instance void [mscorlib]System.IO.FileSystemInfo::Delete()
			IL_032a: nop
			IL_032b: nop

			IL_032c: ldloc.3
			IL_032d: ldarg.1
			IL_032e: callvirt instance void [mscorlib]System.IO.FileInfo::MoveTo(string)
			IL_0333: nop
			IL_0334: nop
			IL_0335: leave.s IL_034b
		} // end .try
		catch [mscorlib]System.Exception
		{
			IL_0337: stloc.s 18
			IL_0339: nop
			IL_033a: ldarg.0
			IL_033b: ldloc.s 18
			IL_033d: ldstr "Overwriting old XML file failed."
			IL_0342: call instance void GetExePath.Program::WriteExceptionLog(class [mscorlib]System.Exception, string)
			IL_0347: nop
			IL_0348: nop
			IL_0349: leave.s IL_034b
		} // end handler

		IL_034b: ldarg.0
		IL_034c: ldfld bool GetExePath.Program::finalizeOnce
		IL_0351: brtrue.s IL_035b

		IL_0353: ldarg.0
		IL_0354: ldfld bool GetExePath.Program::debugLogEnabled
		IL_0359: br.s IL_035c

		IL_035b: ldc.i4.1

		IL_035c: stloc.s 19
		IL_035e: ldloc.s 19
		IL_0360: brfalse.s IL_0387

		IL_0362: nop
		IL_0363: ldloc.0
		IL_0364: callvirt instance void [System]System.Diagnostics.Stopwatch::Stop()
		IL_0369: nop
		IL_036a: ldarg.0
		IL_036b: ldstr "Exiting SaveNewSettings: "
		IL_0370: ldloc.0
		IL_0371: callvirt instance int64 [System]System.Diagnostics.Stopwatch::get_ElapsedMilliseconds()
		IL_0376: box [mscorlib]System.Int64
		IL_037b: call string [mscorlib]System.String::Concat(object, object)
		IL_0380: call instance void GetExePath.Program::WriteInfoLog(string)
		IL_0385: nop
		IL_0386: nop

		IL_0387: nop
		IL_0388: leave.s IL_039e
	} // end .try
	catch [mscorlib]System.Exception
	{
		IL_038a: stloc.s 20
		IL_038c: nop
		IL_038d: ldarg.0
		IL_038e: ldloc.s 20
		IL_0390: ldsfld string [mscorlib]System.String::Empty
		IL_0395: call instance void GetExePath.Program::WriteExceptionLog(class [mscorlib]System.Exception, string)
		IL_039a: nop
		IL_039b: nop
		IL_039c: leave.s IL_039e
	} // end handler

	IL_039e: ret
} // end of method Program::_SaveNewSettings


.method assembly hidebysig 
	instance string ChangeDirNameToPath (
		string fileContents
	) cil managed 
{
	// Method begins at RVA 0x27c4
	// Code size 160 (0xa0)
	.maxstack 3
	.locals init (
		[0] string,
		[1] string,
		[2] string,
		[3] string,
		[4] string,
		[5] string,
		[6] string
	)

	IL_0000: nop
	IL_0001: call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
	IL_0006: callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
	IL_000b: stloc.0
	IL_000c: ldloc.0
	IL_000d: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0012: stloc.1
	IL_0013: ldloc.1
	IL_0014: ldstr "\\"
	IL_0019: ldstr "/"
	IL_001e: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0023: stloc.2
	IL_0024: ldloc.0
	IL_0025: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_002a: call class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.Directory::GetParent(string)
	IL_002f: callvirt instance string [mscorlib]System.Object::ToString()
	IL_0034: stloc.3
	IL_0035: ldloc.3
	IL_0036: ldstr "\\"
	IL_003b: ldstr "/"
	IL_0040: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0045: stloc.s 4
	IL_0047: ldc.i4.s 16
	IL_0049: call string GetExePath.Program::GetFolderPath(valuetype [mscorlib]System.Environment/SpecialFolder)
	IL_004e: stloc.s 5
	IL_0050: ldarg.1
	IL_0051: ldstr "%ActDir%"
	IL_0056: ldloc.1
	IL_0057: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_005c: starg.s fileContents
	IL_005e: ldarg.1
	IL_005f: ldstr "%ActDir2%"
	IL_0064: ldloc.2
	IL_0065: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_006a: starg.s fileContents
	IL_006c: ldarg.1
	IL_006d: ldstr "%ActParentDir%"
	IL_0072: ldloc.3
	IL_0073: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0078: starg.s fileContents
	IL_007a: ldarg.1
	IL_007b: ldstr "%ActParentDir2%"
	IL_0080: ldloc.s 4
	IL_0082: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0087: starg.s fileContents
	IL_0089: ldarg.1
	IL_008a: ldstr "%DesktopDir%"
	IL_008f: ldloc.s 5
	IL_0091: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0096: starg.s fileContents
	IL_0098: ldarg.1
	IL_0099: stloc.s 6
	IL_009b: br.s IL_009d

	IL_009d: ldloc.s 6
	IL_009f: ret
} // end of method Program::ChangeDirNameToPath

.method assembly hidebysig 
	instance string ChangeDirNameToVar (
		string fileContents
	) cil managed 
{
	// Method begins at RVA 0x2718
	// Code size 160 (0xa0)
	.maxstack 3
	.locals init (
		[0] string,
		[1] string,
		[2] string,
		[3] string,
		[4] string,
		[5] string,
		[6] string
	)

	IL_0000: nop
	IL_0001: call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
	IL_0006: callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
	IL_000b: stloc.0
	IL_000c: ldloc.0
	IL_000d: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0012: stloc.1
	IL_0013: ldloc.1
	IL_0014: ldstr "\\"
	IL_0019: ldstr "/"
	IL_001e: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0023: stloc.2
	IL_0024: ldloc.0
	IL_0025: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_002a: call class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.Directory::GetParent(string)
	IL_002f: callvirt instance string [mscorlib]System.Object::ToString()
	IL_0034: stloc.3
	IL_0035: ldloc.3
	IL_0036: ldstr "\\"
	IL_003b: ldstr "/"
	IL_0040: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0045: stloc.s 4
	IL_0047: ldc.i4.s 16
	IL_0049: call string GetExePath.Program::GetFolderPath(valuetype [mscorlib]System.Environment/SpecialFolder)
	IL_004e: stloc.s 5
	IL_0050: ldarg.1
	IL_0051: ldloc.1
	IL_0052: ldstr "%ActDir%"
	IL_0057: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_005c: starg.s fileContents
	IL_005e: ldarg.1
	IL_005f: ldloc.2
	IL_0060: ldstr "%ActDir2%"
	IL_0065: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_006a: starg.s fileContents
	IL_006c: ldarg.1
	IL_006d: ldloc.3
	IL_006e: ldstr "%ActParentDir%"
	IL_0073: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0078: starg.s fileContents
	IL_007a: ldarg.1
	IL_007b: ldloc.s 4
	IL_007d: ldstr "%ActParentDir2%"
	IL_0082: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0087: starg.s fileContents
	IL_0089: ldarg.1
	IL_008a: ldloc.s 5
	IL_008c: ldstr "%DesktopDir%"
	IL_0091: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0096: starg.s fileContents
	IL_0098: ldarg.1
	IL_0099: stloc.s 6
	IL_009b: br.s IL_009d

	IL_009d: ldloc.s 6
	IL_009f: ret
} // end of method Program::ChangeDirNameToVar




.method assembly hidebysig 
	instance void LoadNewSettings (
		string xmlpath
	) cil managed 
{
	// Method begins at RVA 0x2bf4
	// Code size 449 (0x1c1)
	.maxstack 4
	.locals init (
		[0] string,
		[1] string,
		[2] string,
		[3] string,
		[4] string,
		[5] string,
		[6] class [mscorlib]System.Collections.Generic.IEnumerator`1<string>,
		[7] string,
		[8] bool,
		[9] string,
		[10] string,
		[11] bool,
		[12] class [mscorlib]System.Collections.Generic.IEnumerator`1<string>,
		[13] string,
		[14] bool,
		[15] string,
		[16] string,
		[17] bool
	)

	IL_0000: nop
	IL_0001: ldarg.1
	IL_0002: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0007: stloc.0
	IL_0008: call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
	IL_000d: callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
	IL_0012: stloc.1
	IL_0013: ldloc.1
	IL_0014: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0019: stloc.2
	IL_001a: ldloc.2
	IL_001b: ldstr "\\"
	IL_0020: ldstr "/"
	IL_0025: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_002a: stloc.3
	IL_002b: ldloc.1
	IL_002c: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0031: call class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.Directory::GetParent(string)
	IL_0036: callvirt instance string [mscorlib]System.Object::ToString()
	IL_003b: stloc.s 4
	IL_003d: ldloc.s 4
	IL_003f: ldstr "\\"
	IL_0044: ldstr "/"
	IL_0049: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_004e: stloc.s 5
	IL_0050: nop
	IL_0051: ldloc.0
	IL_0052: ldstr "*.xml_"
	IL_0057: ldc.i4.1
	IL_0058: call class [mscorlib]System.Collections.Generic.IEnumerable`1<string> [mscorlib]System.IO.Directory::EnumerateFiles(string, string, valuetype [mscorlib]System.IO.SearchOption)
	IL_005d: callvirt instance class [mscorlib]System.Collections.Generic.IEnumerator`1<!0> class [mscorlib]System.Collections.Generic.IEnumerable`1<string>::GetEnumerator()
	IL_0062: stloc.s 6
	.try
	{
		IL_0064: br IL_00e9
		// loop start (head: IL_00e9)
			IL_0069: ldloc.s 6
			IL_006b: callvirt instance !0 class [mscorlib]System.Collections.Generic.IEnumerator`1<string>::get_Current()
			IL_0070: stloc.s 7
			IL_0072: nop
			IL_0073: ldloc.s 7
			IL_0075: call string [mscorlib]System.IO.Path::GetExtension(string)
			IL_007a: ldstr ".xml_"
			IL_007f: call bool [mscorlib]System.String::op_Equality(string, string)
			IL_0084: stloc.s 8
			IL_0086: ldloc.s 8
			IL_0088: brfalse.s IL_00e8

			IL_008a: nop
			IL_008b: ldloc.s 7
			IL_008d: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
			IL_0092: stloc.s 9
			IL_0094: ldloc.s 9
			IL_0096: call string [mscorlib]System.IO.Path::GetFileName(string)
			IL_009b: callvirt instance string [mscorlib]System.String::ToLower()
			IL_00a0: stloc.s 10
			IL_00a2: ldloc.s 10
			IL_00a4: ldstr "backup"
			IL_00a9: callvirt instance int32 [mscorlib]System.String::IndexOf(string)
			IL_00ae: ldc.i4.0
			IL_00af: clt
			IL_00b1: stloc.s 11
			IL_00b3: ldloc.s 11
			IL_00b5: brfalse.s IL_00e7

			IL_00b7: nop
			IL_00b8: ldloc.s 7
			IL_00ba: ldstr ".xml_"
			IL_00bf: ldstr ".xml"
			IL_00c4: callvirt instance string [mscorlib]System.String::Replace(string, string)
			IL_00c9: ldarg.0
			IL_00ca: ldloc.s 7
			IL_00cc: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_00d1: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
			IL_00d6: call instance string GetExePath.Program::ChangeDirNameToPath(string)
			IL_00db: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_00e0: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
			IL_00e5: nop
			IL_00e6: nop

			IL_00e7: nop

			IL_00e8: nop

			IL_00e9: ldloc.s 6
			IL_00eb: callvirt instance bool [mscorlib]System.Collections.IEnumerator::MoveNext()
			IL_00f0: brtrue IL_0069
		// end loop

		IL_00f5: leave.s IL_0104
	} // end .try
	finally
	{
		IL_00f7: ldloc.s 6
		IL_00f9: brfalse.s IL_0103

		IL_00fb: ldloc.s 6
		IL_00fd: callvirt instance void [mscorlib]System.IDisposable::Dispose()
		IL_0102: nop

		IL_0103: endfinally
	} // end handler

	IL_0104: nop
	IL_0105: ldloc.0
	IL_0106: ldstr "*.json_"
	IL_010b: ldc.i4.1
	IL_010c: call class [mscorlib]System.Collections.Generic.IEnumerable`1<string> [mscorlib]System.IO.Directory::EnumerateFiles(string, string, valuetype [mscorlib]System.IO.SearchOption)
	IL_0111: callvirt instance class [mscorlib]System.Collections.Generic.IEnumerator`1<!0> class [mscorlib]System.Collections.Generic.IEnumerable`1<string>::GetEnumerator()
	IL_0116: stloc.s 12
	.try
	{
		IL_0118: br IL_019d
		// loop start (head: IL_019d)
			IL_011d: ldloc.s 12
			IL_011f: callvirt instance !0 class [mscorlib]System.Collections.Generic.IEnumerator`1<string>::get_Current()
			IL_0124: stloc.s 13
			IL_0126: nop
			IL_0127: ldloc.s 13
			IL_0129: call string [mscorlib]System.IO.Path::GetExtension(string)
			IL_012e: ldstr ".json_"
			IL_0133: call bool [mscorlib]System.String::op_Equality(string, string)
			IL_0138: stloc.s 14
			IL_013a: ldloc.s 14
			IL_013c: brfalse.s IL_019c

			IL_013e: nop
			IL_013f: ldloc.s 13
			IL_0141: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
			IL_0146: stloc.s 15
			IL_0148: ldloc.s 15
			IL_014a: call string [mscorlib]System.IO.Path::GetFileName(string)
			IL_014f: callvirt instance string [mscorlib]System.String::ToLower()
			IL_0154: stloc.s 16
			IL_0156: ldloc.s 16
			IL_0158: ldstr "backup"
			IL_015d: callvirt instance int32 [mscorlib]System.String::IndexOf(string)
			IL_0162: ldc.i4.0
			IL_0163: clt
			IL_0165: stloc.s 17
			IL_0167: ldloc.s 17
			IL_0169: brfalse.s IL_019b

			IL_016b: nop
			IL_016c: ldloc.s 13
			IL_016e: ldstr ".json_"
			IL_0173: ldstr ".json"
			IL_0178: callvirt instance string [mscorlib]System.String::Replace(string, string)
			IL_017d: ldarg.0
			IL_017e: ldloc.s 13
			IL_0180: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_0185: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
			IL_018a: call instance string GetExePath.Program::ChangeDirNameToPath(string)
			IL_018f: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_0194: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
			IL_0199: nop
			IL_019a: nop

			IL_019b: nop

			IL_019c: nop

			IL_019d: ldloc.s 12
			IL_019f: callvirt instance bool [mscorlib]System.Collections.IEnumerator::MoveNext()
			IL_01a4: brtrue IL_011d
		// end loop

		IL_01a9: leave.s IL_01b8
	} // end .try
	finally
	{
		IL_01ab: ldloc.s 12
		IL_01ad: brfalse.s IL_01b7

		IL_01af: ldloc.s 12
		IL_01b1: callvirt instance void [mscorlib]System.IDisposable::Dispose()
		IL_01b6: nop

		IL_01b7: endfinally
	} // end handler

	IL_01b8: ldarg.0
	IL_01b9: ldarg.1
	IL_01ba: call instance void GetExePath.Program::_LoadNewSettings(string)
	IL_01bf: nop
	IL_01c0: ret
} // end of method Program::LoadNewSettings


.method assembly hidebysig 
	instance void SaveNewSettings (
		string xmlpath
	) cil managed 
{
	// Method begins at RVA 0x2de0
	// Code size 449 (0x1c1)
	.maxstack 4
	.locals init (
		[0] string,
		[1] string,
		[2] string,
		[3] string,
		[4] string,
		[5] string,
		[6] class [mscorlib]System.Collections.Generic.IEnumerator`1<string>,
		[7] string,
		[8] bool,
		[9] string,
		[10] string,
		[11] bool,
		[12] class [mscorlib]System.Collections.Generic.IEnumerator`1<string>,
		[13] string,
		[14] bool,
		[15] string,
		[16] string,
		[17] bool
	)

	IL_0000: nop
	IL_0001: ldarg.0
	IL_0002: ldarg.1
	IL_0003: call instance void GetExePath.Program::_SaveNewSettings(string)
	IL_0008: nop
	IL_0009: ldarg.1
	IL_000a: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_000f: stloc.0
	IL_0010: call class [mscorlib]System.Reflection.Assembly [mscorlib]System.Reflection.Assembly::GetExecutingAssembly()
	IL_0015: callvirt instance string [mscorlib]System.Reflection.Assembly::get_Location()
	IL_001a: stloc.1
	IL_001b: ldloc.1
	IL_001c: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0021: stloc.2
	IL_0022: ldloc.2
	IL_0023: ldstr "\\"
	IL_0028: ldstr "/"
	IL_002d: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0032: stloc.3
	IL_0033: ldloc.1
	IL_0034: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
	IL_0039: call class [mscorlib]System.IO.DirectoryInfo [mscorlib]System.IO.Directory::GetParent(string)
	IL_003e: callvirt instance string [mscorlib]System.Object::ToString()
	IL_0043: stloc.s 4
	IL_0045: ldloc.s 4
	IL_0047: ldstr "\\"
	IL_004c: ldstr "/"
	IL_0051: callvirt instance string [mscorlib]System.String::Replace(string, string)
	IL_0056: stloc.s 5
	IL_0058: nop
	IL_0059: ldloc.0
	IL_005a: ldstr "*.xml"
	IL_005f: ldc.i4.1
	IL_0060: call class [mscorlib]System.Collections.Generic.IEnumerable`1<string> [mscorlib]System.IO.Directory::EnumerateFiles(string, string, valuetype [mscorlib]System.IO.SearchOption)
	IL_0065: callvirt instance class [mscorlib]System.Collections.Generic.IEnumerator`1<!0> class [mscorlib]System.Collections.Generic.IEnumerable`1<string>::GetEnumerator()
	IL_006a: stloc.s 6
	.try
	{
		IL_006c: br IL_00f1
		// loop start (head: IL_00f1)
			IL_0071: ldloc.s 6
			IL_0073: callvirt instance !0 class [mscorlib]System.Collections.Generic.IEnumerator`1<string>::get_Current()
			IL_0078: stloc.s 7
			IL_007a: nop
			IL_007b: ldloc.s 7
			IL_007d: call string [mscorlib]System.IO.Path::GetExtension(string)
			IL_0082: ldstr ".xml"
			IL_0087: call bool [mscorlib]System.String::op_Equality(string, string)
			IL_008c: stloc.s 8
			IL_008e: ldloc.s 8
			IL_0090: brfalse.s IL_00f0

			IL_0092: nop
			IL_0093: ldloc.s 7
			IL_0095: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
			IL_009a: stloc.s 9
			IL_009c: ldloc.s 9
			IL_009e: call string [mscorlib]System.IO.Path::GetFileName(string)
			IL_00a3: callvirt instance string [mscorlib]System.String::ToLower()
			IL_00a8: stloc.s 10
			IL_00aa: ldloc.s 10
			IL_00ac: ldstr "backup"
			IL_00b1: callvirt instance int32 [mscorlib]System.String::IndexOf(string)
			IL_00b6: ldc.i4.0
			IL_00b7: clt
			IL_00b9: stloc.s 11
			IL_00bb: ldloc.s 11
			IL_00bd: brfalse.s IL_00ef

			IL_00bf: nop
			IL_00c0: ldloc.s 7
			IL_00c2: ldstr ".xml"
			IL_00c7: ldstr ".xml_"
			IL_00cc: callvirt instance string [mscorlib]System.String::Replace(string, string)
			IL_00d1: ldarg.0
			IL_00d2: ldloc.s 7
			IL_00d4: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_00d9: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
			IL_00de: call instance string GetExePath.Program::ChangeDirNameToVar(string)
			IL_00e3: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_00e8: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
			IL_00ed: nop
			IL_00ee: nop

			IL_00ef: nop

			IL_00f0: nop

			IL_00f1: ldloc.s 6
			IL_00f3: callvirt instance bool [mscorlib]System.Collections.IEnumerator::MoveNext()
			IL_00f8: brtrue IL_0071
		// end loop

		IL_00fd: leave.s IL_010c
	} // end .try
	finally
	{
		IL_00ff: ldloc.s 6
		IL_0101: brfalse.s IL_010b

		IL_0103: ldloc.s 6
		IL_0105: callvirt instance void [mscorlib]System.IDisposable::Dispose()
		IL_010a: nop

		IL_010b: endfinally
	} // end handler

	IL_010c: nop
	IL_010d: ldloc.0
	IL_010e: ldstr "*.json"
	IL_0113: ldc.i4.1
	IL_0114: call class [mscorlib]System.Collections.Generic.IEnumerable`1<string> [mscorlib]System.IO.Directory::EnumerateFiles(string, string, valuetype [mscorlib]System.IO.SearchOption)
	IL_0119: callvirt instance class [mscorlib]System.Collections.Generic.IEnumerator`1<!0> class [mscorlib]System.Collections.Generic.IEnumerable`1<string>::GetEnumerator()
	IL_011e: stloc.s 12
	.try
	{
		IL_0120: br IL_01a5
		// loop start (head: IL_01a5)
			IL_0125: ldloc.s 12
			IL_0127: callvirt instance !0 class [mscorlib]System.Collections.Generic.IEnumerator`1<string>::get_Current()
			IL_012c: stloc.s 13
			IL_012e: nop
			IL_012f: ldloc.s 13
			IL_0131: call string [mscorlib]System.IO.Path::GetExtension(string)
			IL_0136: ldstr ".json"
			IL_013b: call bool [mscorlib]System.String::op_Equality(string, string)
			IL_0140: stloc.s 14
			IL_0142: ldloc.s 14
			IL_0144: brfalse.s IL_01a4

			IL_0146: nop
			IL_0147: ldloc.s 13
			IL_0149: call string [mscorlib]System.IO.Path::GetDirectoryName(string)
			IL_014e: stloc.s 15
			IL_0150: ldloc.s 15
			IL_0152: call string [mscorlib]System.IO.Path::GetFileName(string)
			IL_0157: callvirt instance string [mscorlib]System.String::ToLower()
			IL_015c: stloc.s 16
			IL_015e: ldloc.s 16
			IL_0160: ldstr "backup"
			IL_0165: callvirt instance int32 [mscorlib]System.String::IndexOf(string)
			IL_016a: ldc.i4.0
			IL_016b: clt
			IL_016d: stloc.s 17
			IL_016f: ldloc.s 17
			IL_0171: brfalse.s IL_01a3

			IL_0173: nop
			IL_0174: ldloc.s 13
			IL_0176: ldstr ".json"
			IL_017b: ldstr ".json_"
			IL_0180: callvirt instance string [mscorlib]System.String::Replace(string, string)
			IL_0185: ldarg.0
			IL_0186: ldloc.s 13
			IL_0188: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_018d: call string [mscorlib]System.IO.File::ReadAllText(string, class [mscorlib]System.Text.Encoding)
			IL_0192: call instance string GetExePath.Program::ChangeDirNameToVar(string)
			IL_0197: call class [mscorlib]System.Text.Encoding [mscorlib]System.Text.Encoding::get_UTF8()
			IL_019c: call void [mscorlib]System.IO.File::WriteAllText(string, string, class [mscorlib]System.Text.Encoding)
			IL_01a1: nop
			IL_01a2: nop

			IL_01a3: nop

			IL_01a4: nop

			IL_01a5: ldloc.s 12
			IL_01a7: callvirt instance bool [mscorlib]System.Collections.IEnumerator::MoveNext()
			IL_01ac: brtrue IL_0125
		// end loop

		IL_01b1: leave.s IL_01c0
	} // end .try
	finally
	{
		IL_01b3: ldloc.s 12
		IL_01b5: brfalse.s IL_01bf

		IL_01b7: ldloc.s 12
		IL_01b9: callvirt instance void [mscorlib]System.IDisposable::Dispose()
		IL_01be: nop

		IL_01bf: endfinally
	} // end handler

	IL_01c0: ret
} // end of method Program::SaveNewSettings

