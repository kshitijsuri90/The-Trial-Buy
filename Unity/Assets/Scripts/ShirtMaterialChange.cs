using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;


public class ShirtMaterialChange : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{
    public GameObject target;
    public Material material1;
    private GameObject shirts;
    private GameObject shirtsParent;

    //Detect current clicks on the GameObject (the one with the script attached)
    public void OnPointerDown(PointerEventData pointerEventData)
    {
        target = GameObject.Find("Interaction").GetComponent<TapToPlaceObject>().modelObject;
        //target.SetActive(false);

         shirtsParent=target.transform.GetChild(4).gameObject;
         shirtsParent.SetActive(true);
         shirts=target.transform.GetChild(4).GetChild(0).gameObject;
        shirts.SetActive(true);

        shirts.GetComponent<MeshRenderer>().material=material1;

        //Output the name of the GameObject that is being clicked
        Debug.Log( "Game Object Click in Progress");
    }

    //Detect if clicks are no longer registering
    public void OnPointerUp(PointerEventData pointerEventData)
    {
        Debug.Log( "No longer being clicked");
    }
    
}
