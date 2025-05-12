using UnityEngine;
using TMPro;

public class LevelUIManager : MonoBehaviour
{
    [SerializeField] TextMeshProUGUI levelText;
    [SerializeField] float displayDuration = 3f;

    void Start()
    {
        levelText.gameObject.SetActive(true);
        Invoke("HideLevelText", displayDuration);
    }

    void HideLevelText()
    {
        levelText.gameObject.SetActive(false);
    }
}
