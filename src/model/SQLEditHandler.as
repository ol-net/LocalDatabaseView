package model
{
	import flash.events.EventDispatcher;
	
	public class SQLEditHandler
	{
		import flash.data.SQLStatement;
		import flash.data.SQLResult;
		import flash.events.SQLEvent;
		import flash.events.SQLErrorEvent;
		
		private var insertStatement:SQLStatement;
		private var result:SQLResult;
		private var con:SQLConnectionHandler;
		
		static private var instance:SQLEditHandler;
		
		static public function getInstance():SQLEditHandler
		{
			if (instance == null) 
			{
				instance = new SQLEditHandler();
			}
			
			return instance;
		}
		
		public function insertUser(textInput:String):void
		{
			con = SQLConnectionHandler.getInstance();
			
			insertStatement = new SQLStatement();	
			insertStatement.sqlConnection = con.getSQLConncection();
			
			insertStatement.text = "insert into mh2go (user) values (:user)";
			
			insertStatement.parameters[":user"] = textInput;
			
			insertStatement.execute();
		}
	}
}