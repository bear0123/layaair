package laya.d3.loaders {
	import laya.d3.core.material.BaseMaterial;
	import laya.d3.resource.models.Mesh;
	import laya.d3.resource.models.SubMesh;
	import laya.utils.Byte;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MeshReader {
		
		public function MeshReader() {
		}
		
		public static function read(data:ArrayBuffer, mesh:Mesh, materials:Vector.<BaseMaterial>, subMeshes:Vector.<SubMesh>, materialMap:Object):void {
			var readData:Byte = new Byte(data);
			readData.pos = 0;
			var version:String = readData.readUTFString();
			switch (version) {
			case "LAYAMODEL:01": 
			case "LAYASKINANI:01": 
				_readVersion01(readData, version, mesh, materials, subMeshes, materialMap);
				break;
			case "LAYAMODEL:02": 
				_readVersion02(readData, version, mesh, materials, subMeshes, materialMap);
				break;
			default: 
				throw new Error("MeshReader: unknown mesh version.");
			}
			mesh._setSubMeshes(subMeshes);
		}
		
		private static function _readVersion01(readData:Byte, version:String, mesh:Mesh, materials:Vector.<BaseMaterial>, subMeshes:Vector.<SubMesh>, materialMap:Object):void {
			new LoadModelV01(readData, version, mesh, materials, subMeshes, materialMap);
		}
		
		private static function _readVersion02(readData:Byte, version:String, mesh:Mesh, materials:Vector.<BaseMaterial>, subMeshes:Vector.<SubMesh>, materialMap:Object):void {
			LoadModelV02.parse(readData, version, mesh, materials, subMeshes, materialMap);
		}
	}
}