using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour 
{

	private Vector2 pos;
	private bool moving = false;
	public bool inBattle = false;


	void Start () 
	{

        pos = transform.position;
	}


	
	// Update is called once per frame
	void Update () 
	{
		CheckInput();
		
		if(moving)
		{

			transform.position = pos;
			moving = false;
		}
	}

	private void CheckInput()
	{
		if (Input.GetKeyDown(KeyCode.D))
		{
			pos += Vector2.right;
		}

		else if (Input.GetKeyDown(KeyCode.A))
		{
			pos -= Vector2.right;
		}

		else if (Input.GetKeyDown(KeyCode.W))
		{
			pos += Vector2.up;
		}

		else if (Input.GetKeyDown(KeyCode.S))
		{
			pos -= Vector2.up;
		}
		moving = true;
	}

	void OnCollisionEnter2D(Collision2D coll)
	{
		if(coll.gameObject.tag.Equals("Enemy"))
		{
			inBattle = true;
			Debug.Log("touch");
		}
		Debug.Log("no touch");
	}
}
