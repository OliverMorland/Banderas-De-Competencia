using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Attacker : MonoBehaviour
{
    public GameObject[] opponents;


    private void Update()
    {
        for (int i = 0; i < opponents.Length; i++)
        {
            DirToOpponent(opponents[i]);
        }
    }
    /*
    Vector3 FindSpace()
    {
       
    }
    */
    Vector3 DirToOpponent(GameObject opponent)
    {
        Vector3 opponentPos = opponent.transform.position;
        Vector3 dirToOpponent = (opponentPos - transform.position).normalized;
        Debug.DrawLine(transform.position, transform.position + dirToOpponent, Color.red);
        return dirToOpponent;
    }
}
