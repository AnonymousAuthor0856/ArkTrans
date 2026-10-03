/*
 * NotificationActivity - Single-file Compose UI for reminder postpone.
 * Transparent activity showing date/time picker dialogs sequentially.
 * All components, theme, and tokens embedded inline.
 */

package com.maltaisn.notes.ui.notification

import android.content.Intent
import android.os.Bundle
import android.text.format.DateFormat
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDefaults
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DisplayMode
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TimePicker
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.maltaisn.notes.model.entity.Note
import com.maltaisn.notes.receiver.AlarmReceiver
import com.maltaisn.notes.ui.observeEvent
import dagger.hilt.android.AndroidEntryPoint
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import java.util.TimeZone


private const val NAME = "NotesApp_NotificationActivity"
private const val UI_TYPE = "Reminder Postpone"
private const val STYLE_THEME = "Transparent"
private const val LANG = "en"
private const val BASELINE_SIZE = "360x640"


object AppTokens {
    object Colors {
        val primary = Color(0xFF1E6D3B)
        val onPrimary = Color(0xFFFFFFFF)
        val primaryContainer = Color(0xFFD7F5D9)
        val onPrimaryContainer = Color(0xFF00210A)
        val secondary = Color(0xFF516351)
        val secondaryContainer = Color(0xFFD4E8D3)
        val error = Color(0xFFBA1A1A)
        val onError = Color(0xFFFFFFFF)
        val background = Color(0xFFF8FBF1)
        val onBackground = Color(0xFF191D19)
        val surface = Color(0xFFF8FBF1)
        val onSurface = Color(0xFF191D19)
        val surfaceVariant = Color(0xFFDDE5DA)
        val onSurfaceVariant = Color(0xFF424940)
        val outline = Color(0xFF727970)
        val outlineVariant = Color(0xFFC1C9BE)
    }

    object TypographyTokens {
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }

    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
        val extraLarge = RoundedCornerShape(24.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(8.dp, 12.dp, 6.dp, 0.16f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    primaryContainer = AppTokens.Colors.primaryContainer,
    onPrimaryContainer = AppTokens.Colors.onPrimaryContainer,
    secondary = AppTokens.Colors.secondary,
    secondaryContainer = AppTokens.Colors.secondaryContainer,
    error = AppTokens.Colors.error,
    onError = AppTokens.Colors.onError,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    onSurfaceVariant = AppTokens.Colors.onSurfaceVariant,
    outline = AppTokens.Colors.outline,
    outlineVariant = AppTokens.Colors.outlineVariant,
)

private val AppTypography = Typography(
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label,
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.extraLarge,
        ),
        content = content,
    )
}



data class DialogCallbacks(
    val onDateDismiss: () -> Unit = {},
    val onDateConfirm: (Long) -> Unit = {},
    val onTimeDismiss: () -> Unit = {},
    val onTimeConfirm: (Int, Int) -> Unit = { _, _ -> },
)


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun NotificationDialogs(
    showDatePicker: Boolean,
    showTimePicker: Boolean,
    postponeDate: Long?,
    callbacks: DialogCallbacks,
    modifier: Modifier = Modifier,
) {
    // Transparent background - only dialogs are visible
    Box(modifier = modifier.fillMaxSize()) {
        // Date picker dialog
        if (showDatePicker) {
            val datePickerState = rememberDatePickerState(
                initialDisplayMode = DisplayMode.Picker,
                initialSelectedDateMillis = postponeDate ?: System.currentTimeMillis(),
            )

            DatePickerDialog(
                onDismissRequest = {
                    callbacks.onDateDismiss()
                },
                confirmButton = {
                    TextButton(onClick = {
                        datePickerState.selectedDateMillis?.let { selected ->
                            val calendar = Calendar.getInstance()
                            calendar.timeInMillis = selected - TimeZone.getDefault().getOffset(selected)
                            callbacks.onDateConfirm(
                                calendar.timeInMillis
                            )
                        } ?: callbacks.onDateDismiss()
                    }) {
                        Text("Next", color = AppTokens.Colors.primary)
                    }
                },
                dismissButton = {
                    TextButton(onClick = {
                        callbacks.onDateDismiss()
                    }) {
                        Text("Cancel")
                    }
                },
                colors = DatePickerDefaults.colors(
                    containerColor = AppTokens.Colors.surface,
                    selectedDayContentColor = AppTokens.Colors.onPrimary,
                    selectedDayContainerColor = AppTokens.Colors.primary,
                    todayDateBorderColor = AppTokens.Colors.primary,
                    todayContentColor = AppTokens.Colors.primary,
                ),
            ) {
                DatePicker(
                    state = datePickerState,
                )
            }
        }

        // Time picker dialog
        if (showTimePicker) {
            val calendar = Calendar.getInstance().apply {
                postponeDate?.let { timeInMillis = it }
            }
            val timePickerState = rememberTimePickerState(
                initialHour = calendar[Calendar.HOUR_OF_DAY],
                initialMinute = calendar[Calendar.MINUTE],
                is24Hour = DateFormat.is24HourFormat(
                    androidx.compose.ui.platform.LocalContext.current
                ),
            )

            AlertDialog(
                onDismissRequest = {
                    callbacks.onTimeDismiss()
                },
                title = {
                    Text(
                        "Set time",
                        color = AppTokens.Colors.onSurface,
                    )
                },
                text = {
                    TimePicker(state = timePickerState)
                },
                confirmButton = {
                    TextButton(onClick = {
                        callbacks.onTimeConfirm(timePickerState.hour, timePickerState.minute)
                    }) {
                        Text("Set", color = AppTokens.Colors.primary)
                    }
                },
                dismissButton = {
                    TextButton(onClick = {
                        callbacks.onTimeDismiss()
                    }) {
                        Text("Cancel")
                    }
                },
                containerColor = AppTokens.Colors.surface,
            )
        }
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen(
    viewModel: NotificationViewModel,
    onExit: () -> Unit,
) {
    val showDateEvent by viewModel.showDateDialogEvent.observeAsState()
    val showTimeEvent by viewModel.showTimeDialogEvent.observeAsState()
    val exitEvent by viewModel.exitEvent.observeAsState()

    var showDatePicker by remember { mutableStateOf(false) }
    var showTimePicker by remember { mutableStateOf(false) }
    var postponeDate by remember { mutableStateOf<Long?>(null) }

    // Consume ViewModel events
    LaunchedEffect(showDateEvent) {
        showDateEvent?.let { event ->
            if (!event.hasBeenHandled) {
                val date = event.requireUnhandledContent()
                postponeDate = date
                showDatePicker = true
            }
        }
    }

    LaunchedEffect(showTimeEvent) {
        showTimeEvent?.let { event ->
            if (!event.hasBeenHandled) {
                val date = event.requireUnhandledContent()
                postponeDate = date
                showTimePicker = true
            }
        }
    }

    LaunchedEffect(exitEvent) {
        exitEvent?.let { event ->
            if (!event.hasBeenHandled) {
                event.requireUnhandledContent()
                onExit()
            }
        }
    }

    val callbacks = remember(viewModel) {
        DialogCallbacks(
            onDateDismiss = {
                showDatePicker = false
                viewModel.cancelPostpone()
            },
            onDateConfirm = { selectedMillis ->
                showDatePicker = false
                val calendar = Calendar.getInstance()
                calendar.timeInMillis = selectedMillis
                viewModel.setPostponeDate(
                    calendar[Calendar.YEAR],
                    calendar[Calendar.MONTH],
                    calendar[Calendar.DAY_OF_MONTH],
                )
            },
            onTimeDismiss = {
                showTimePicker = false
                viewModel.cancelPostpone()
            },
            onTimeConfirm = { hour, minute ->
                showTimePicker = false
                viewModel.setPostponeTime(hour, minute)
            },
        )
    }

    NotificationDialogs(
        showDatePicker = showDatePicker,
        showTimePicker = showTimePicker,
        postponeDate = postponeDate,
        callbacks = callbacks,
    )
}


@AndroidEntryPoint
class NotificationActivity : ComponentActivity() {

    private val viewModel: NotificationViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Transparent - no edge-to-edge needed since this is a transparent activity
        WindowCompat.setDecorFitsSystemWindows(window, false)

        setupViewModelObservers()

        setContent {
            AppTheme {
                RootScreen(
                    viewModel = viewModel,
                    onExit = { finish() },
                )
            }
        }

        handleIntent(intent)
    }

    private fun setupViewModelObservers() {
        viewModel.clearNotificationEvent.observeEvent(this) { noteId ->
            androidx.core.app.NotificationManagerCompat.from(this).cancel(noteId.toInt())
        }
        viewModel.exitEvent.observeEvent(this) {
            finish()
        }
    }

    private fun handleIntent(intent: Intent) {
        if (!intent.getBooleanExtra(KEY_INTENT_HANDLED, false)) {
            when (intent.action) {
                INTENT_ACTION_POSTPONE -> {
                    val noteId = intent.getLongExtra(AlarmReceiver.EXTRA_NOTE_ID, Note.NO_ID)
                    viewModel.onPostponeClicked(noteId)
                }
            }
            intent.putExtra(KEY_INTENT_HANDLED, true)
        }
    }

    companion object {
        private const val KEY_INTENT_HANDLED = "com.maltaisn.notes.INTENT_HANDLED"
        const val INTENT_ACTION_POSTPONE = "com.maltaisn.notes.reminder.POSTPONE"
    }
}



@OptIn(ExperimentalMaterial3Api::class)
@Preview(showBackground = true, backgroundColor = 0xFFF8FBF1)
@Composable
fun PreviewNotificationScreen() {
    AppTheme {
        NotificationDialogs(
            showDatePicker = true,
            showTimePicker = false,
            postponeDate = System.currentTimeMillis(),
            callbacks = DialogCallbacks(),
        )
    }
}
