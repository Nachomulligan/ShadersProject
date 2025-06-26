using UnityEngine;

public class SpectatorMovement : MonoBehaviour
{
    [Header("Movement Settings")]
    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float fastMoveSpeed = 10f;
    [SerializeField] private float mouseSensitivity = 2f;
    [SerializeField] private float smoothTime = 0.1f;

    [Header("Camera Settings")]
    [SerializeField] private float minVerticalAngle = -90f;
    [SerializeField] private float maxVerticalAngle = 90f;

    // Private variables
    private Vector3 velocity;
    private Vector3 currentVelocity;
    private float verticalRotation = 0f;
    private float horizontalRotation = 0f;

    // Input tracking
    private Vector2 mouseInput;
    private Vector3 moveInput;
    private bool isFastMoving;

    void Start()
    {
        // Configurar cursor
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;

        // Inicializar rotación basada en la rotación actual
        Vector3 currentRotation = transform.eulerAngles;
        horizontalRotation = currentRotation.y;
        verticalRotation = currentRotation.x;

        // Ajustar vertical rotation si está en el rango 270-360 (equivalente a -90 a 0)
        if (verticalRotation > 180f)
            verticalRotation -= 360f;
    }

    void Update()
    {
        HandleInput();
        HandleMouseLook();
        HandleMovement();

        // Permitir desbloquear cursor con ESC
        if (Input.GetKeyDown(KeyCode.Escape))
            ToggleCursor();
    }

    void HandleInput()
    {
        // Input de mouse
        mouseInput.x = Input.GetAxis("Mouse X");
        mouseInput.y = Input.GetAxis("Mouse Y");

        // Input de movimiento
        moveInput.x = Input.GetAxis("Horizontal"); // A/D
        moveInput.z = Input.GetAxis("Vertical");   // W/S

        // Movimiento vertical (Q/E o Space/Ctrl)
        moveInput.y = 0f;
        if (Input.GetKey(KeyCode.Q) || Input.GetKey(KeyCode.LeftControl))
            moveInput.y = -1f;
        if (Input.GetKey(KeyCode.E) || Input.GetKey(KeyCode.Space))
            moveInput.y = 1f;

        // Movimiento rápido (Shift)
        isFastMoving = Input.GetKey(KeyCode.LeftShift);
    }

    void HandleMouseLook()
    {
        // Aplicar sensibilidad del mouse
        horizontalRotation += mouseInput.x * mouseSensitivity;
        verticalRotation -= mouseInput.y * mouseSensitivity;

        // Limitar rotación vertical
        verticalRotation = Mathf.Clamp(verticalRotation, minVerticalAngle, maxVerticalAngle);

        // Aplicar rotación
        transform.rotation = Quaternion.Euler(verticalRotation, horizontalRotation, 0f);
    }

    void HandleMovement()
    {
        // Calcular velocidad objetivo
        float currentSpeed = isFastMoving ? fastMoveSpeed : moveSpeed;

        // Convertir input a movimiento relativo al transform
        Vector3 targetVelocity = transform.TransformDirection(moveInput) * currentSpeed;

        // Aplicar smoothing al movimiento
        velocity = Vector3.SmoothDamp(velocity, targetVelocity, ref currentVelocity, smoothTime);

        // Mover el transform
        transform.Translate(velocity * Time.deltaTime, Space.World);
    }

    void ToggleCursor()
    {
        if (Cursor.lockState == CursorLockMode.Locked)
        {
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }
        else
        {
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;
        }
    }

    // Métodos públicos útiles
    public void SetPosition(Vector3 newPosition)
    {
        transform.position = newPosition;
        velocity = Vector3.zero;
        currentVelocity = Vector3.zero;
    }

    public void SetRotation(Vector3 eulerAngles)
    {
        horizontalRotation = eulerAngles.y;
        verticalRotation = eulerAngles.x;

        if (verticalRotation > 180f)
            verticalRotation -= 360f;

        transform.rotation = Quaternion.Euler(verticalRotation, horizontalRotation, 0f);
    }

    public Vector3 GetVelocity() => velocity;
    public bool IsMoving() => velocity.magnitude > 0.1f;
    public bool IsFastMoving() => isFastMoving;

    // Método para cambiar velocidad en runtime
    public void SetMoveSpeed(float newSpeed)
    {
        moveSpeed = newSpeed;
    }

    public void SetFastMoveSpeed(float newSpeed)
    {
        fastMoveSpeed = newSpeed;
    }

    public void SetMouseSensitivity(float newSensitivity)
    {
        mouseSensitivity = newSensitivity;
    }
}