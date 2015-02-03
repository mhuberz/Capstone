using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour 
{

	private Vector2 pos;
	private bool moving = false;


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
}
