/*
 * EditActivity - Single-file Compose UI for note creation and editing.
 * All components, theme, and tokens embedded inline.
 */

package com.maltaisn.notes.ui.edit

import android.content.Intent
import android.os.Bundle
import android.view.KeyEvent
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.ContentCopy
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Label
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.material.icons.filled.PushPin
import androidx.compose.material.icons.filled.Share
import androidx.compose.material.icons.outlined.Alarm
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.maltaisn.notes.model.entity.Note
import com.maltaisn.notes.model.entity.NoteStatus
import com.maltaisn.notes.model.entity.NoteType
import com.maltaisn.notes.ui.EXTRA_NOTE_CONTENT
import com.maltaisn.notes.ui.EXTRA_NOTE_ID
import com.maltaisn.notes.ui.EXTRA_NOTE_TITLE
import com.maltaisn.notes.ui.EXTRA_NOTE_TYPE
import com.maltaisn.notes.ui.RESULT_NOTE_CREATED_ID
import com.maltaisn.notes.ui.SharedViewModel
import com.maltaisn.notes.ui.observeEvent
import com.maltaisn.notes.ui.edit.actions.EditActionAvailability
import com.maltaisn.notes.model.entity.Label
import com.maltaisn.notes.model.entity.Reminder
import dagger.hilt.android.AndroidEntryPoint



private const val NAME = "NotesApp_EditActivity"
private const val UI_TYPE = "Notes Editor"
private const val STYLE_THEME = "Material3"
private const val LANG = "en"
private const val BASELINE_SIZE = "360x640"


object AppTokens {
    object Colors {
        val primary = Color(0xFF1E6D3B)
        val onPrimary = Color(0xFFFFFFFF)
        val primaryContainer = Color(0xFFD7F5D9)
        val onPrimaryContainer = Color(0xFF00210A)
        val secondary = Color(0xFF516351)
        val onSecondary = Color(0xFFFFFFFF)
        val secondaryContainer = Color(0xFFD4E8D3)
        val onSecondaryContainer = Color(0xFF0F1F12)
        val tertiary = Color(0xFF3A656F)
        val onTertiary = Color(0xFFFFFFFF)
        val tertiaryContainer = Color(0xFFBDEAF6)
        val onTertiaryContainer = Color(0xFF001F26)
        val error = Color(0xFFBA1A1A)
        val onError = Color(0xFFFFFFFF)
        val errorContainer = Color(0xFFFFDAD6)
        val onErrorContainer = Color(0xFF410002)
        val background = Color(0xFFF8FBF1)
        val onBackground = Color(0xFF191D19)
        val surface = Color(0xFFF8FBF1)
        val onSurface = Color(0xFF191D19)
        val surfaceVariant = Color(0xFFDDE5DA)
        val onSurfaceVariant = Color(0xFF424940)
        val outline = Color(0xFF727970)
        val outlineVariant = Color(0xFFC1C9BE)
        val surfaceContainer = Color(0xFFECF0E6)
        val surfaceContainerHigh = Color(0xFFE7EAE0)
        val surfaceDim = Color(0xFFD8DCD3)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 15.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
        val caption = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Normal)
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
        val xxl = 36.dp
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
    onSecondary = AppTokens.Colors.onSecondary,
    secondaryContainer = AppTokens.Colors.secondaryContainer,
    onSecondaryContainer = AppTokens.Colors.onSecondaryContainer,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    error = AppTokens.Colors.error,
    onError = AppTokens.Colors.onError,
    errorContainer = AppTokens.Colors.errorContainer,
    onErrorContainer = AppTokens.Colors.onErrorContainer,
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
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
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



data class EditorUiState(
    val noteId: Long = Note.NO_ID,
    val title: String = "",
    val content: String = "",
    val noteType: NoteType = NoteType.TEXT,
    val noteStatus: NoteStatus = NoteStatus.ACTIVE,
    val isPinned: Boolean = false,
    val labels: List<Label> = emptyList(),
    val reminder: Reminder? = null,
    val listItems: List<ChecklistItemState> = emptyList(),
    val showDate: Boolean = false,
    val dateText: String = "",
    val isSaving: Boolean = false,
    val showDeleteConfirm: Boolean = false,
    val showLinkDialog: String? = null,
)

data class ChecklistItemState(
    val id: Long,
    val text: String,
    val checked: Boolean,
)


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen(
    viewModel: EditViewModel,
    sharedViewModel: SharedViewModel,
    onExit: () -> Unit,
) {
    var uiState by remember { mutableStateOf(EditorUiState()) }
    var showOverflow by remember { mutableStateOf(false) }
    var showDeleteDialog by remember { mutableStateOf(false) }
    var showLinkDialogUrl by remember { mutableStateOf<String?>(null) }


    val exitEvent by viewModel.exitEvent.observeAsState()

    LaunchedEffect(exitEvent) {
        exitEvent?.let { event ->
            if (!event.hasBeenHandled) {
                event.requireUnhandledContent()
                onExit()
            }
        }
    }

    Scaffold(
        containerColor = AppTokens.Colors.background,
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        if (uiState.noteId == Note.NO_ID) "New Note" else "Edit Note",
                        color = AppTokens.Colors.onSurface,
                    )
                },
                navigationIcon = {
                    IconButton(onClick = {
                        viewModel.saveNote()
                        onExit()
                    }) {
                        Icon(
                            Icons.AutoMirrored.Filled.ArrowBack,
                            contentDescription = "Back",
                            tint = AppTokens.Colors.onSurface,
                        )
                    }
                },
                actions = {
                    IconButton(onClick = { viewModel.togglePin() }) {
                        Icon(
                            Icons.Filled.PushPin,
                            contentDescription = "Pin",
                            tint = if (uiState.isPinned) AppTokens.Colors.primary
                            else AppTokens.Colors.onSurfaceVariant,
                        )
                    }

                    IconButton(onClick = { viewModel.changeReminder() }) {
                        Icon(
                            Icons.Outlined.Alarm,
                            contentDescription = "Reminder",
                            tint = if (uiState.reminder != null) AppTokens.Colors.primary
                            else AppTokens.Colors.onSurfaceVariant,
                        )
                    }

                    IconButton(onClick = { viewModel.changeLabels() }) {
                        Icon(
                            Icons.Filled.Label,
                            contentDescription = "Labels",
                            tint = AppTokens.Colors.onSurfaceVariant,
                        )
                    }

                    Box {
                        IconButton(onClick = { showOverflow = true }) {
                            Icon(
                                Icons.Filled.MoreVert,
                                contentDescription = "More",
                                tint = AppTokens.Colors.onSurface,
                            )
                        }
                        DropdownMenu(
                            expanded = showOverflow,
                            onDismissRequest = { showOverflow = false },
                        ) {
                            DropdownMenuItem(
                                text = { Text("Convert to List") },
                                leadingIcon = {
                                    Icon(Icons.Filled.Check, contentDescription = null)
                                },
                                onClick = {
                                    showOverflow = false
                                    viewModel.toggleNoteType()
                                },
                            )
                            DropdownMenuItem(
                                text = { Text("Copy") },
                                leadingIcon = {
                                    Icon(Icons.Filled.ContentCopy, contentDescription = null)
                                },
                                onClick = {
                                    showOverflow = false
                                    viewModel.copyNote("Untitled", "(copy)")
                                },
                            )
                            DropdownMenuItem(
                                text = { Text("Share") },
                                leadingIcon = {
                                    Icon(Icons.Filled.Share, contentDescription = null)
                                },
                                onClick = {
                                    showOverflow = false
                                    viewModel.shareNote()
                                },
                            )
                            if (uiState.noteStatus == NoteStatus.DELETED) {
                                DropdownMenuItem(
                                    text = { Text("Restore") },
                                    leadingIcon = {
                                        Icon(Icons.Filled.Add, contentDescription = null)
                                    },
                                    onClick = {
                                        showOverflow = false
                                        viewModel.restoreNoteAndEdit()
                                    },
                                )
                            }
                            HorizontalDivider()
                            DropdownMenuItem(
                                text = {
                                    Text(
                                        "Delete",
                                        color = AppTokens.Colors.error,
                                    )
                                },
                                leadingIcon = {
                                    Icon(
                                        Icons.Filled.Delete,
                                        contentDescription = null,
                                        tint = AppTokens.Colors.error,
                                    )
                                },
                                onClick = {
                                    showOverflow = false
                                    showDeleteDialog = true
                                },
                            )
                        }
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = AppTokens.Colors.surface,
                ),
            )
        },
        modifier = Modifier.onKeyEvent { keyEvent ->
            if (keyEvent.nativeKeyEvent.isCtrlPressed) {
                when (keyEvent.key) {
                    Key.Z -> { sharedViewModel.undo(); true }
                    Key.Y -> { sharedViewModel.redo(); true }
                    else -> false
                }
            } else false
        },
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.lg),
        ) {
            // Date display
            if (uiState.showDate) {
                Text(
                    text = uiState.dateText,
                    style = MaterialTheme.typography.labelMedium,
                    color = AppTokens.Colors.onSurfaceVariant,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = AppTokens.Spacing.sm),
                )
            }

            // Title
            OutlinedTextField(
                value = uiState.title,
                onValueChange = { newTitle ->
                    uiState = uiState.copy(title = newTitle)
                },
                placeholder = { Text("Title", color = AppTokens.Colors.onSurfaceVariant) },
                textStyle = MaterialTheme.typography.headlineMedium.copy(
                    fontSize = 22.sp,
                ),
                singleLine = true,
                keyboardOptions = KeyboardOptions(
                    capitalization = KeyboardCapitalization.Sentences,
                    imeAction = ImeAction.Next,
                ),
                colors = TextFieldDefaults.colors(
                    focusedIndicatorColor = Color.Transparent,
                    unfocusedIndicatorColor = Color.Transparent,
                    focusedTextColor = AppTokens.Colors.onSurface,
                    unfocusedTextColor = AppTokens.Colors.onSurface,
                    cursorColor = AppTokens.Colors.primary,
                    focusedContainerColor = Color.Transparent,
                    unfocusedContainerColor = Color.Transparent,
                ),
                modifier = Modifier.fillMaxWidth(),
            )

            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            when (uiState.noteType) {
                NoteType.TEXT -> {
                    OutlinedTextField(
                        value = uiState.content,
                        onValueChange = { newContent ->
                            uiState = uiState.copy(content = newContent)
                        },
                        placeholder = { Text("Start writing...", color = AppTokens.Colors.onSurfaceVariant) },
                        textStyle = MaterialTheme.typography.bodyMedium,
                        keyboardOptions = KeyboardOptions(
                            capitalization = KeyboardCapitalization.Sentences,
                            keyboardType = KeyboardType.Text,
                        ),
                        colors = TextFieldDefaults.colors(
                            focusedIndicatorColor = Color.Transparent,
                            unfocusedIndicatorColor = Color.Transparent,
                            focusedTextColor = AppTokens.Colors.onSurface,
                            unfocusedTextColor = AppTokens.Colors.onSurface,
                            cursorColor = AppTokens.Colors.primary,
                            focusedContainerColor = Color.Transparent,
                            unfocusedContainerColor = Color.Transparent,
                        ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .weight(1f),
                    )
                }

                NoteType.LIST -> {
                    LazyColumn(
                        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                        modifier = Modifier.weight(1f),
                    ) {
                        itemsIndexed(uiState.listItems) { index, item ->
                            Row(
                                verticalAlignment = Alignment.CenterVertically,
                                modifier = Modifier.fillMaxWidth(),
                            ) {
                                Checkbox(
                                    checked = item.checked,
                                    onCheckedChange = { checked ->
                                        val updated = uiState.listItems.toMutableList()
                                        updated[index] = item.copy(checked = checked)
                                        uiState = uiState.copy(listItems = updated)
                                    },
                                    colors = androidx.compose.material3.CheckboxDefaults.colors(
                                        checkedColor = AppTokens.Colors.primary,
                                    ),
                                )
                                OutlinedTextField(
                                    value = item.text,
                                    onValueChange = { newText ->
                                        val updated = uiState.listItems.toMutableList()
                                        updated[index] = item.copy(text = newText)
                                        uiState = uiState.copy(listItems = updated)
                                    },
                                    placeholder = { Text("List item", color = AppTokens.Colors.onSurfaceVariant) },
                                    textStyle = MaterialTheme.typography.bodyMedium,
                                    singleLine = false,
                                    keyboardOptions = KeyboardOptions(
                                        capitalization = KeyboardCapitalization.Sentences,
                                        imeAction = ImeAction.Default,
                                    ),
                                    colors = TextFieldDefaults.colors(
                                        focusedIndicatorColor = Color.Transparent,
                                        unfocusedIndicatorColor = Color.Transparent,
                                        focusedTextColor = AppTokens.Colors.onSurface,
                                        unfocusedTextColor = AppTokens.Colors.onSurface,
                                        cursorColor = AppTokens.Colors.primary,
                                        focusedContainerColor = Color.Transparent,
                                        unfocusedContainerColor = Color.Transparent,
                                    ),
                                    modifier = Modifier.weight(1f),
                                )
                                IconButton(
                                    onClick = {
                                        val updated = uiState.listItems.toMutableList()
                                        updated.removeAt(index)
                                        uiState = uiState.copy(listItems = updated)
                                    },
                                ) {
                                    Icon(
                                        Icons.Filled.Close,
                                        contentDescription = "Remove item",
                                        tint = AppTokens.Colors.onSurfaceVariant,
                                        modifier = Modifier.size(18.dp),
                                    )
                                }
                            }
                        }
                        item {
                            TextButton(
                                onClick = {
                                    val updated = uiState.listItems.toMutableList()
                                    updated.add(
                                        ChecklistItemState(
                                            id = System.currentTimeMillis(),
                                            text = "",
                                            checked = false,
                                        )
                                    )
                                    uiState = uiState.copy(listItems = updated)
                                },
                            ) {
                                Icon(Icons.Filled.Add, contentDescription = null, modifier = Modifier.size(18.dp))
                                Spacer(modifier = Modifier.width(AppTokens.Spacing.xs))
                                Text("Add item")
                            }
                        }
                    }
                }
            }

            if (uiState.labels.isNotEmpty() || uiState.reminder != null) {
                Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                Row(
                    horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                    modifier = Modifier.fillMaxWidth(),
                ) {
                    uiState.labels.forEach { label ->
                        FilterChip(
                            selected = true,
                            onClick = { viewModel.changeLabels() },
                            label = { Text(label.name, style = AppTokens.TypographyTokens.caption) },
                            colors = androidx.compose.material3.FilterChipDefaults.filterChipColors(
                                selectedContainerColor = AppTokens.Colors.secondaryContainer,
                                selectedLabelColor = AppTokens.Colors.onSecondaryContainer,
                            ),
                        )
                    }
                    if (uiState.reminder != null) {
                        FilterChip(
                            selected = true,
                            onClick = { viewModel.changeReminder() },
                            leadingIcon = {
                                Icon(
                                    Icons.Outlined.Alarm,
                                    contentDescription = null,
                                    modifier = Modifier.size(16.dp),
                                )
                            },
                            label = { Text("Reminder", style = AppTokens.TypographyTokens.caption) },
                            colors = androidx.compose.material3.FilterChipDefaults.filterChipColors(
                                selectedContainerColor = AppTokens.Colors.tertiaryContainer,
                                selectedLabelColor = AppTokens.Colors.onTertiaryContainer,
                            ),
                        )
                    }
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
            }
        }
    }

    // Delete confirmation dialog
    if (showDeleteDialog) {
        AlertDialog(
            onDismissRequest = { showDeleteDialog = false },
            title = { Text("Delete note?") },
            text = { Text("This note will be moved  to trash.") },
            confirmButton = {
                TextButton(onClick = {
                    showDeleteDialog = false
                    viewModel.deleteNote()
                }) {
                    Text("Delete", color = AppTokens.Colors.error)
                }
            },
            dismissButton = {
                TextButton(onClick = { showDeleteDialog = false }) {
                    Text("Cancel")
                }
            },
            containerColor = AppTokens.Colors.surface,
        )
    }

    // Link dialog
    showLinkDialogUrl?.let { url ->
        AlertDialog(
            onDismissRequest = { showLinkDialogUrl = null },
            title = { Text("Open link?") },
            text = { Text(url, maxLines = 2, overflow = TextOverflow.Ellipsis) },
            confirmButton = {
                TextButton(onClick = {
                    showLinkDialogUrl = null
                    viewModel.openClickedLink()
                }) {
                    Text("Open")
                }
            },
            dismissButton = {
                TextButton(onClick = { showLinkDialogUrl = null }) {
                    Text("Cancel")
                }
            },
            containerColor = AppTokens.Colors.surface,
        )
    }
}


@AndroidEntryPoint
class EditActivity : ComponentActivity() {

    val viewModel: EditViewModel by viewModels()
    private val sharedViewModel: SharedViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Edge-to-edge
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())

        // Read intent
        val noteId = intent.getLongExtra(EXTRA_NOTE_ID, Note.NO_ID)
        val noteType = NoteType.fromValue(intent.getIntExtra(EXTRA_NOTE_TYPE, 0))
        val title = intent.getStringExtra(EXTRA_NOTE_TITLE) ?: ""
        val content = intent.getStringExtra(EXTRA_NOTE_CONTENT) ?: ""

        viewModel.start(noteId, 0L, false, noteType, title, content)

        setupViewModelObservers()

        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    EditRootScreenPreview(title = "", content = "", noteType = NoteType.TEXT)
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }

    override fun onStop() {
        super.onStop()
        viewModel.saveNote()
    }

    override fun onKeyShortcut(keyCode: Int, event: KeyEvent): Boolean {
        if (event.isCtrlPressed && !event.isShiftPressed) {
            when (event.keyCode) {
                KeyEvent.KEYCODE_Z -> { sharedViewModel.undo(); return true }
                KeyEvent.KEYCODE_Y -> { sharedViewModel.redo(); return true }
            }
        } else if (event.isCtrlPressed && event.isShiftPressed) {
            when (event.keyCode) {
                KeyEvent.KEYCODE_Z -> { sharedViewModel.redo(); return true }
            }
        }
        return super.onKeyShortcut(keyCode, event)
    }

    private fun setupViewModelObservers() {
        viewModel.noteCreateEvent.observeEvent(this) { noteId ->
            sharedViewModel.noteCreated(noteId)
        }
        viewModel.exitEvent.observeEvent(this) {
            finishWithResult()
        }
    }

    private fun finishWithResult() {
        val resultIntent = Intent().apply {
            putExtra(RESULT_NOTE_CREATED_ID, Note.NO_ID)
        }
        setResult(RESULT_OK, resultIntent)
        finish()
    }
}


@Preview(showBackground = true, backgroundColor = 0xFFF8FBF1)
@Composable
fun PreviewEditEmpty() {
    EditRootScreenPreview(title = "", content = "", noteType = NoteType.TEXT)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EditRootScreenPreview(title: String, content: String, noteType: NoteType) {
    var showOverflow by remember { mutableStateOf(false) }

    AppTheme {
        Surface(color = AppTokens.Colors.background) {
            Scaffold(
                containerColor = AppTokens.Colors.background,
                topBar = {
                    TopAppBar(
                        title = { Text("Edit Note", color = AppTokens.Colors.onSurface) },
                        navigationIcon = {
                            IconButton(onClick = {}) {
                                Icon(Icons.AutoMirrored.Filled.ArrowBack, "Back", tint = AppTokens.Colors.onSurface)
                            }
                        },
                        actions = {
                            IconButton(onClick = {}) {
                                Icon(Icons.Filled.PushPin, "Pin", tint = AppTokens.Colors.onSurfaceVariant)
                            }
                            IconButton(onClick = {}) {
                                Icon(Icons.Outlined.Alarm, "Reminder", tint = AppTokens.Colors.onSurfaceVariant)
                            }
                            IconButton(onClick = {}) {
                                Icon(Icons.Filled.Label, "Labels", tint = AppTokens.Colors.onSurfaceVariant)
                            }
                            Box {
                                IconButton(onClick = { showOverflow = true }) {
                                    Icon(Icons.Filled.MoreVert, "More", tint = AppTokens.Colors.onSurface)
                                }
                                DropdownMenu(expanded = showOverflow, onDismissRequest = { showOverflow = false }) {
                                    DropdownMenuItem(text = { Text("Convert to List") }, leadingIcon = { Icon(Icons.Filled.Check, null) }, onClick = { showOverflow = false })
                                    DropdownMenuItem(text = { Text("Copy") }, leadingIcon = { Icon(Icons.Filled.ContentCopy, null) }, onClick = { showOverflow = false })
                                    DropdownMenuItem(text = { Text("Share") }, leadingIcon = { Icon(Icons.Filled.Share, null) }, onClick = { showOverflow = false })
                                }
                            }
                        },
                        colors = TopAppBarDefaults.topAppBarColors(containerColor = AppTokens.Colors.surface),
                    )
                },
            ) { padding ->
                Column(modifier = Modifier.padding(padding).fillMaxSize().padding(horizontal = AppTokens.Spacing.lg)) {
                    OutlinedTextField(
                        value = title, onValueChange = {},
                        placeholder = { Text("Title", color = AppTokens.Colors.onSurfaceVariant) },
                        textStyle = MaterialTheme.typography.headlineMedium.copy(fontSize = 22.sp),
                        singleLine = true,
                        colors = TextFieldDefaults.colors(focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent, focusedTextColor = AppTokens.Colors.onSurface, unfocusedTextColor = AppTokens.Colors.onSurface, focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent),
                        modifier = Modifier.fillMaxWidth(),
                    )
                    Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                    when (noteType) {
                        NoteType.TEXT -> OutlinedTextField(
                            value = content, onValueChange = {},
                            placeholder = { Text("Start writing...", color = AppTokens.Colors.onSurfaceVariant) },
                            textStyle = MaterialTheme.typography.bodyMedium,
                            colors = TextFieldDefaults.colors(focusedIndicatorColor = Color.Transparent, unfocusedIndicatorColor = Color.Transparent, focusedTextColor = AppTokens.Colors.onSurface, unfocusedTextColor = AppTokens.Colors.onSurface, focusedContainerColor = Color.Transparent, unfocusedContainerColor = Color.Transparent),
                            modifier = Modifier.fillMaxWidth().weight(1f),
                        )
                        NoteType.LIST -> {
                            val items = content.split("\n")
                            LazyColumn(modifier = Modifier.weight(1f)) {
                                itemsIndexed(items) { index, text ->
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Checkbox(checked = false, onCheckedChange = {})
                                        Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
                                        Text(text, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
