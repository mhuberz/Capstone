using UnityEngine;
using System.Collections;

public class WorldController : MonoBehaviour 
{

	public ArrayList enemyList;
	// Use this for initialization
	void Start () 
	{
	
	}
	void Awake()
	{
		enemyList = new ArrayList();
	}
	// Update is called once per frame
	void Update () 
	{

	}
}
