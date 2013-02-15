package model
{
	import flash.events.EventDispatcher;
	
	public class SQLViewHandler extends EventDispatcher
	{
		import flash.data.SQLStatement;
		import flash.data.SQLResult;
		import flash.events.SQLEvent;
		import flash.events.SQLErrorEvent;
		import mx.collections.ArrayCollection;
		import events.SQLConnectionIsOpen;
		
		private var selectStatement:SQLStatement;
		private var result:SQLResult;
		private var resultArr:ArrayCollection;
		private var con:SQLConnectionHandler;
		
		static private var instance:SQLViewHandler;
		
		static public function getInstance():SQLViewHandler
		{
			if (instance == null) 
			{
				instance = new SQLViewHandler();
			}
			
			return instance;
		}
		
		public function initSQLView():void
		{		
			con = SQLConnectionHandler.getInstance();
			
			selectStatement = new SQLStatement();	
			selectStatement.sqlConnection = con.getSQLConncection();
			
			selectStatement.text = "SELECT user FROM mh2go ORDER BY id DESC";
			
			selectStatement.addEventListener(SQLEvent.RESULT, resultHandlerSelect); 
			selectStatement.addEventListener(SQLErrorEvent.ERROR, errorHandler); 
			
			selectStatement.execute();
		}
		
		public function resultHandlerSelect(event:SQLEvent):void
		{ 
			result = selectStatement.getResult(); 
			
			var rArr:Array = result.data;
			
			if(result)
			{      
				resultArr = new ArrayCollection();
			}
			
			var numResults:int = result.data.length; 
			
			for (var i:int = 0; i < numResults; i++) 
			{ 
				var row:Object = result.data[i]; 
				var output:String = row.user;
				resultArr.addItem(output);
			} 
			
			var eCon:SQLConnectionIsOpen = new SQLConnectionIsOpen(SQLConnectionIsOpen.READERCOMPLETE);
			
			this.dispatchEvent(eCon);
		}
		
		public function getCollectionArray():ArrayCollection
		{
			return resultArr;
		}
		
		public function errorHandler(event:SQLErrorEvent):void 
		{ 
		}
	}
}