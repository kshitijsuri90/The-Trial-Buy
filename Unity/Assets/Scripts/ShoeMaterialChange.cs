using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ShoeMaterialChange : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{

    public GameObject target;
    public Material material1;
    private GameObject shoe1;
    private GameObject shoe2;

    //Detect current clicks on the GameObject (the one with the script attached)
    public void OnPointerDown(PointerEventData pointerEventData)
    {
        target = GameObject.Find("Interaction").GetComponent<TapToPlaceObject>().modelObject;
        //target.SetActive(false);

         shoe1=target.transform.GetChild(7).gameObject;
         shoe2=target.transform.GetChild(8).gameObject;
         shoe1.SetActive(true);
         shoe2.SetActive(true);

        shoe1.GetComponent<MeshRenderer>().material=material1;
        shoe2.GetComponent<MeshRenderer>().material=material1;

        //Output the name of the GameObject that is being clicked
        Debug.Log( "Game Object Click in Progress");
    }

    //Detect if clicks are no longer registering
    public void OnPointerUp(PointerEventData pointerEventData)
    {
        Debug.Log( "No longer being clicked");
    }
}
