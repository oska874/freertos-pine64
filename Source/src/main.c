#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"


#define mainQUEUE_LENGTH                    ( 1 )
#define mainQUEUE_RECEIVE_TASK_PRIORITY     ( 2 )

static QueueHandle_t xQueue = NULL;

void prvQueueSendTask( void *pvParameters )
{

}

void main(void)
{
    xQueue = xQueueCreate( mainQUEUE_LENGTH, sizeof( uint32_t ) );

    xTaskCreate( prvQueueSendTask,           
                "Rx",                           
                configMINIMAL_STACK_SIZE,       
                NULL,                           
                mainQUEUE_RECEIVE_TASK_PRIORITY,
                NULL );                         

    /* Start the tasks and timer running. */
    vTaskStartScheduler();
}
