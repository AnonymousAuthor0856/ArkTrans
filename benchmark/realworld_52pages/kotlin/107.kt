/*
 * SettingsActivity - Single-file Compose UI for app settings.
 * All components, theme, and tokens embedded inline.
 */

package com.maltaisn.notes.ui.settings

import android.content.Intent
import android.os.Bundle
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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.OpenInNew
import androidx.compose.material.icons.automirrored.filled.Sort
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.FileCopy
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Palette
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Share
import androidx.compose.material.icons.filled.ToggleOff
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Slider
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.maltaisn.notes.ui.SharedViewModel
import dagger.hilt.android.AndroidEntryPoint

private const val NAME = "NotesApp_SettingsActivity"
private const val UI_TYPE = "Notes Settings"
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
        val surfaceDim = Color(0xFFD8DCD3)
    }

    object TypographyTokens {
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
        val caption = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Normal)
    }

    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
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
        ),
        content = content,
    )
}



data class SettingsGroup(
    val title: String,
    val icon: ImageVector,
    val items: List<SettingsItem>,
)

sealed class SettingsItem {
    data class Switch(
        val title: String,
        val subtitle: String = "",
        val checked: Boolean,
        val onToggle: (Boolean) -> Unit,
    ) : SettingsItem()

    data class Dropdown(
        val title: String,
        val subtitle: String = "",
        val value: String,
        val options: List<String>,
        val onSelect: (String) -> Unit,
    ) : SettingsItem()

    data class SliderSetting(
        val title: String,
        val subtitle: String = "",
        val value: Float,
        val valueRange: ClosedFloatingPointRange<Float>,
        val onValueChange: (Float) -> Unit,
    ) : SettingsItem()

    data class Action(
        val title: String,
        val subtitle: String = "",
        val icon: ImageVector? = null,
        val onClick: () -> Unit,
    ) : SettingsItem()

    data class Navigate(
        val title: String,
        val subtitle: String = "",
        val onClick: () -> Unit,
    ) : SettingsItem()
}



@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen(
    viewModel: SettingsViewModel,
    onExit: () -> Unit,
) {
    // Preference state (simplified - in real app these come from PrefsManager)
    var themeValue by remember { mutableStateOf("System") }
    var dynamicColors by remember { mutableStateOf(false) }
    var strikethrough by remember { mutableStateOf(true) }
    var textSize by remember { mutableStateOf(15f) }
    var previewLabels by remember { mutableStateOf(2f) }
    var shownDate by remember { mutableStateOf("Modified") }
    var swipeLeft by remember { mutableStateOf("Archive") }
    var swipeRight by remember { mutableStateOf("Delete") }
    var markAsDone by remember { mutableStateOf("Archive") }
    var trashTimeout by remember { mutableStateOf("7 days") }
    var editFocus by remember { mutableStateOf("Title") }
    var moveCheckedToBottom by remember { mutableStateOf(false) }
    var encryptedExport by remember { mutableStateOf(false) }
    var autoExport by remember { mutableStateOf(false) }
    var showClearDialog by remember { mutableStateOf(false) }

    val messageEvent by viewModel.messageEvent.observeAsState()

    val groups = listOf(
        SettingsGroup(
            title = "Appearance",
            icon = Icons.Filled.Palette,
            items = listOf(
                SettingsItem.Dropdown("Theme", "Light, dark, or system default",
                    themeValue, listOf("System", "Light", "Dark")) { themeValue = it },
                SettingsItem.Switch("Dynamic colors", "Use Material You colors",
                    dynamicColors) { dynamicColors = it },
                SettingsItem.Switch("Strikethrough checked", "Strikethrough text on checked items",
                    strikethrough) { strikethrough = it },
                SettingsItem.SliderSetting("Text size", "Note content text size: ${textSize.toInt()}sp",
                    textSize, 10f..20f) { textSize = it },
                SettingsItem.SliderSetting("Preview labels", "Max labels shown in note card: ${previewLabels.toInt()}",
                    previewLabels, 0f..10f) { previewLabels = it },
                SettingsItem.Dropdown("Shown date", "Which date to show on note cards",
                    shownDate, listOf("None", "Created", "Modified")) { shownDate = it },
                SettingsItem.Navigate("Preview lines", "Configure preview lines for grid/list") { },
            ),
        ),
        SettingsGroup(
            title = "Behavior",
            icon = Icons.AutoMirrored.Filled.Sort,
            items = listOf(
                SettingsItem.Dropdown("Swipe left action", "",
                    swipeLeft, listOf("None", "Archive", "Delete")) { swipeLeft = it },
                SettingsItem.Dropdown("Swipe right action", "",
                    swipeRight, listOf("None", "Archive", "Delete")) { swipeRight = it },
                SettingsItem.Dropdown("Mark as done action", "Action after marking reminder as done",
                    markAsDone, listOf("None", "Archive", "Delete")) { markAsDone = it },
                SettingsItem.Dropdown("Trash timeout", "Time before notes are permanently deleted",
                    trashTimeout, listOf("1 day", "7 days", "30 days", "Never")) { trashTimeout = it },
                SettingsItem.Dropdown("Edit initial focus", "What to focus when opening editor",
                    editFocus, listOf("Title", "Content")) { editFocus = it },
                SettingsItem.Switch("Move checked to bottom", "Move checked items to bottom of list",
                    moveCheckedToBottom) { moveCheckedToBottom = it },
            ),
        ),
        SettingsGroup(
            title = "Data",
            icon = Icons.Filled.FileCopy,
            items = listOf(
                SettingsItem.Action("Export data", "Export notes as JSON",
                    Icons.Filled.Share) { /* viewModel.exportData() */ },
                SettingsItem.Switch("Encrypted export", "Password-protect exported data",
                    encryptedExport) { encryptedExport = it },
                SettingsItem.Switch("Auto export", "Automatically export on schedule",
                    autoExport) { autoExport = it },
                SettingsItem.Action("Import data", "Import notes from JSON",
                    Icons.Filled.FileCopy) { /* viewModel.importData() */ },
                SettingsItem.Action("Export archive", "Export as ZIP with attachments") { },
                SettingsItem.Action("Clear data", "Delete all notes and labels",
                    Icons.Filled.Delete) { showClearDialog = true },
            ),
        ),
        SettingsGroup(
            title = "About",
            icon = Icons.Filled.Info,
            items = listOf(
                SettingsItem.Action("View source", "Open project on GitHub",
                    Icons.AutoMirrored.Filled.OpenInNew) { },
                SettingsItem.Action("Version", "1.6.2") { },
            ),
        ),
    )

    Scaffold(
        containerColor = AppTokens.Colors.background,
        topBar = {
            TopAppBar(
                title = { Text("Settings", color = AppTokens.Colors.onSurface) },
                navigationIcon = {
                    IconButton(onClick = onExit) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back",
                            tint = AppTokens.Colors.onSurface)
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = AppTokens.Colors.surface),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.padding(padding),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
        ) {
            groups.forEach { group ->
                item {
                    SettingsGroupCard(group)
                }
            }
            item {
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl))
            }
        }
    }

    // Clear data confirmation
    if (showClearDialog) {
        AlertDialog(
            onDismissRequest = { showClearDialog = false },
            title = { Text("Clear all data?") },
            text = { Text("This will permanently delete all notes, labels, and reminders. This action cannot be undone.") },
            confirmButton = {
                TextButton(onClick = {
                    showClearDialog = false
                    // viewModel.clearData()
                }) {
                    Text("Clear", color = AppTokens.Colors.error)
                }
            },
            dismissButton = {
                TextButton(onClick = { showClearDialog = false }) {
                    Text("Cancel")
                }
            },
            containerColor = AppTokens.Colors.surface,
        )
    }
}


@Composable
fun SettingsGroupCard(group: SettingsGroup) {
    Column {
        // Section header
        Row(
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.xl, vertical = AppTokens.Spacing.sm),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Icon(group.icon, contentDescription = null,
                tint = AppTokens.Colors.primary, modifier = Modifier.size(20.dp))
            Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
            Text(
                group.title,
                style = MaterialTheme.typography.titleMedium,
                color = AppTokens.Colors.primary,
            )
        }

        // Items
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = AppTokens.Spacing.lg),
            shape = AppTokens.Shapes.medium,
            colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
        ) {
            Column {
                group.items.forEachIndexed { index, item ->
                    SettingsItemRow(item)
                    if (index < group.items.size - 1) {
                        HorizontalDivider(
                            color = AppTokens.Colors.outlineVariant,
                            modifier = Modifier.padding(horizontal = AppTokens.Spacing.lg),
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun SettingsItemRow(item: SettingsItem) {
    when (item) {
        is SettingsItem.Switch -> {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { item.onToggle(!item.checked) }
                    .padding(AppTokens.Spacing.lg),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(item.title, style = MaterialTheme.typography.bodyMedium,
                        color = AppTokens.Colors.onSurface)
                    if (item.subtitle.isNotEmpty()) {
                        Text(item.subtitle, style = AppTokens.TypographyTokens.caption,
                            color = AppTokens.Colors.onSurfaceVariant)
                    }
                }
                Switch(
                    checked = item.checked,
                    onCheckedChange = item.onToggle,
                    colors = androidx.compose.material3.SwitchDefaults.colors(
                        checkedThumbColor = AppTokens.Colors.primary,
                        checkedTrackColor = AppTokens.Colors.primaryContainer,
                    ),
                )
            }
        }

        is SettingsItem.Dropdown -> {
            var expanded by remember { mutableStateOf(false) }
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { expanded = true }
                    .padding(AppTokens.Spacing.lg),
            ) {
                Text(item.title, style = MaterialTheme.typography.bodyMedium,
                    color = AppTokens.Colors.onSurface)
                if (item.subtitle.isNotEmpty()) {
                    Text(item.subtitle, style = AppTokens.TypographyTokens.caption,
                        color = AppTokens.Colors.onSurfaceVariant)
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text(item.value, style = MaterialTheme.typography.labelMedium,
                        color = AppTokens.Colors.primary)
                    Icon(Icons.Filled.ChevronRight, contentDescription = null,
                        tint = AppTokens.Colors.onSurfaceVariant, modifier = Modifier.size(18.dp))
                }
            }
            // Dropdown menu
            androidx.compose.material3.DropdownMenu(
                expanded = expanded,
                onDismissRequest = { expanded = false },
            ) {
                item.options.forEach { option ->
                    androidx.compose.material3.DropdownMenuItem(
                        text = { Text(option) },
                        onClick = {
                            item.onSelect(option)
                            expanded = false
                        },
                        leadingIcon = if (option == item.value) {
                            { Icon(Icons.Filled.Check, contentDescription = null, tint = AppTokens.Colors.primary) }
                        } else null,
                    )
                }
            }
        }

        is SettingsItem.SliderSetting -> {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(AppTokens.Spacing.lg),
            ) {
                Text(item.title, style = MaterialTheme.typography.bodyMedium,
                    color = AppTokens.Colors.onSurface)
                if (item.subtitle.isNotEmpty()) {
                    Text(item.subtitle, style = AppTokens.TypographyTokens.caption,
                        color = AppTokens.Colors.onSurfaceVariant)
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                Slider(
                    value = item.value,
                    onValueChange = item.onValueChange,
                    valueRange = item.valueRange,
                    steps = (item.valueRange.endInclusive - item.valueRange.start).toInt() - 1,
                    colors = androidx.compose.material3.SliderDefaults.colors(
                        thumbColor = AppTokens.Colors.primary,
                        activeTrackColor = AppTokens.Colors.primary,
                        inactiveTrackColor = AppTokens.Colors.primaryContainer,
                    ),
                )
            }
        }

        is SettingsItem.Action -> {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { item.onClick() }
                    .padding(AppTokens.Spacing.lg),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                if (item.icon != null) {
                    Icon(item.icon, contentDescription = null,
                        tint = AppTokens.Colors.onSurfaceVariant, modifier = Modifier.size(20.dp))
                    Spacer(modifier = Modifier.width(AppTokens.Spacing.md))
                }
                Column(modifier = Modifier.weight(1f)) {
                    Text(item.title, style = MaterialTheme.typography.bodyMedium,
                        color = AppTokens.Colors.onSurface)
                    if (item.subtitle.isNotEmpty()) {
                        Text(item.subtitle, style = AppTokens.TypographyTokens.caption,
                            color = AppTokens.Colors.onSurfaceVariant)
                    }
                }
                Icon(Icons.Filled.ChevronRight, contentDescription = null,
                    tint = AppTokens.Colors.onSurfaceVariant, modifier = Modifier.size(18.dp))
            }
        }

        is SettingsItem.Navigate -> {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { item.onClick() }
                    .padding(AppTokens.Spacing.lg),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(item.title, style = MaterialTheme.typography.bodyMedium,
                        color = AppTokens.Colors.onSurface)
                    if (item.subtitle.isNotEmpty()) {
                        Text(item.subtitle, style = AppTokens.TypographyTokens.caption,
                            color = AppTokens.Colors.onSurfaceVariant)
                    }
                }
                Icon(Icons.Filled.ChevronRight, contentDescription = null,
                    tint = AppTokens.Colors.onSurfaceVariant, modifier = Modifier.size(18.dp))
            }
        }
    }
}

@AndroidEntryPoint
class SettingsActivity : ComponentActivity() {

    private val viewModel: SettingsViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    SettingsRootScreenPreview(onExit = { finish() })
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

    companion object {
        const val EXTRA_PREFS_XML = "prefsXml"
        const val EXTRA_PREFS_TITLE = "prefsTitle"

        fun newNestedIntent(context: android.content.Context, prefsXml: Int, titleRes: Int): Intent {
            return Intent(context, SettingsActivity::class.java).apply {
                putExtra(EXTRA_PREFS_XML, prefsXml)
                putExtra(EXTRA_PREFS_TITLE, titleRes)
            }
        }
    }
}


@Preview(showBackground = true, backgroundColor = 0xFFF8FBF1)
@Composable
fun PreviewSettingsScreen() {
    SettingsRootScreenPreview(onExit = {})
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsRootScreenPreview(onExit: () -> Unit) {
    var themeValue by remember { mutableStateOf("System") }
    var dynamicColors by remember { mutableStateOf(false) }
    var strikethrough by remember { mutableStateOf(true) }
    var textSize by remember { mutableStateOf(15f) }
    var previewLabels by remember { mutableStateOf(2f) }
    var shownDate by remember { mutableStateOf("Modified") }
    var swipeLeft by remember { mutableStateOf("Archive") }
    var swipeRight by remember { mutableStateOf("Delete") }
    var markAsDone by remember { mutableStateOf("Archive") }
    var trashTimeout by remember { mutableStateOf("7 days") }
    var editFocus by remember { mutableStateOf("Title") }
    var moveCheckedToBottom by remember { mutableStateOf(false) }
    var encryptedExport by remember { mutableStateOf(false) }
    var autoExport by remember { mutableStateOf(false) }
    var showClearDialog by remember { mutableStateOf(false) }

    val groups = listOf(
        SettingsGroup(
            title = "Appearance",
            icon = Icons.Filled.Palette,
            items = listOf(
                SettingsItem.Dropdown("Theme", "Light, dark, or system default",
                    themeValue, listOf("System", "Light", "Dark")) { themeValue = it },
                SettingsItem.Switch("Dynamic colors", "Use Material You colors",
                    dynamicColors) { dynamicColors = it },
                SettingsItem.Switch("Strikethrough checked", "Strikethrough text on checked items",
                    strikethrough) { strikethrough = it },
                SettingsItem.SliderSetting("Text size", "Note content text size: ${textSize.toInt()}sp",
                    textSize, 10f..20f) { textSize = it },
                SettingsItem.SliderSetting("Preview labels", "Max labels shown in note card: ${previewLabels.toInt()}",
                    previewLabels, 0f..10f) { previewLabels = it },
                SettingsItem.Dropdown("Shown date", "Which date to show on note cards",
                    shownDate, listOf("None", "Created", "Modified")) { shownDate = it },
                SettingsItem.Navigate("Preview lines", "Configure preview lines for grid/list") { },
            ),
        ),
        SettingsGroup(
            title = "Behavior",
            icon = Icons.AutoMirrored.Filled.Sort,
            items = listOf(
                SettingsItem.Dropdown("Swipe left action", "", swipeLeft, listOf("None", "Archive", "Delete")) { swipeLeft = it },
                SettingsItem.Dropdown("Swipe right action", "", swipeRight, listOf("None", "Archive", "Delete")) { swipeRight = it },
                SettingsItem.Dropdown("Mark as done action", "Action after marking reminder as done",
                    markAsDone, listOf("None", "Archive", "Delete")) { markAsDone = it },
                SettingsItem.Dropdown("Trash timeout", "Time before notes are permanently deleted",
                    trashTimeout, listOf("1 day", "7 days", "30 days", "Never")) { trashTimeout = it },
                SettingsItem.Dropdown("Edit initial focus", "What to focus when opening editor",
                    editFocus, listOf("Title", "Content")) { editFocus = it },
                SettingsItem.Switch("Move checked to bottom", "Move checked items to bottom of list",
                    moveCheckedToBottom) { moveCheckedToBottom = it },
            ),
        ),
        SettingsGroup(
            title = "Data",
            icon = Icons.Filled.FileCopy,
            items = listOf(
                SettingsItem.Action("Export data", "Export notes as JSON", Icons.Filled.Share) { },
                SettingsItem.Switch("Encrypted export", "Password-protect exported data",
                    encryptedExport) { encryptedExport = it },
                SettingsItem.Switch("Auto export", "Automatically export on schedule",
                    autoExport) { autoExport = it },
                SettingsItem.Action("Import data", "Import notes from JSON", Icons.Filled.FileCopy) { },
                SettingsItem.Action("Export archive", "Export as ZIP with attachments") { },
                SettingsItem.Action("Clear data", "Delete all notes and labels",
                    Icons.Filled.Delete) { showClearDialog = true },
            ),
        ),
        SettingsGroup(
            title = "About",
            icon = Icons.Filled.Info,
            items = listOf(
                SettingsItem.Action("View source", "Open project on GitHub",
                    Icons.AutoMirrored.Filled.OpenInNew) { },
                SettingsItem.Action("Version", "1.6.2") { },
            ),
        ),
    )

    AppTheme {
        Surface(color = AppTokens.Colors.background) {
            Scaffold(
                containerColor = AppTokens.Colors.background,
                topBar = {
                    TopAppBar(
                        title = { Text("Settings", color = AppTokens.Colors.onSurface) },
                        navigationIcon = {
                            IconButton(onClick = onExit) {
                                Icon(Icons.AutoMirrored.Filled.ArrowBack, "Back", tint = AppTokens.Colors.onSurface)
                            }
                        },
                        colors = TopAppBarDefaults.topAppBarColors(containerColor = AppTokens.Colors.surface),
                    )
                },
            ) { padding ->
                LazyColumn(
                    modifier = Modifier.padding(padding),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                ) {
                    groups.forEach { group ->
                        item { SettingsGroupCard(group) }
                    }
                    item { Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl)) }
                }
            }

            if (showClearDialog) {
                AlertDialog(
                    onDismissRequest = { showClearDialog = false },
                    title = { Text("Clear all data?") },
                    text = { Text("This will permanently delete all notes, labels, and reminders. This action cannot be undone.") },
                    confirmButton = {
                        TextButton(onClick = { showClearDialog = false }) {
                            Text("Clear", color = AppTokens.Colors.error)
                        }
                    },
                    dismissButton = {
                        TextButton(onClick = { showClearDialog = false }) { Text("Cancel") }
                    },
                    containerColor = AppTokens.Colors.surface,
                )
            }
        }
    }
}
