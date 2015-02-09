using UnityEngine;
using System.Collections;

public class EnemyList : MonoBehaviour {

	// Use this for initialization
	void Start () 
	{
		GameObject.FindGameObjectWithTag("Player").GetComponent<WorldController>().enemyList.Add(this);
		Debug.Log("added");
	}
	
	// Update is called once per frame
	void Update () 
	{

	}

	void OnDestroy()
	{
		GameObject.FindGameObjectWithTag("Player").GetComponent<WorldController>().enemyList.Remove(this);
		Debug.Log("removed");

	}



}
