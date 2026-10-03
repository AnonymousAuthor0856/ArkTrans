package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
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

private const val NAME = "109AssetInventoryen"
private const val UI_TYPE = "Form"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111111)
        val secondary = Color(0xFF2A2A2A)
        val tertiary = Color(0xFF474747)
        val background = Color(0xFFF6F6F6)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFEDEDED)
        val outline = Color(0xFFD1D1D1)
        val success = Color(0xFF2E7D32)
        val warning = Color(0xFFB98900)
        val error = Color(0xFFB3261E)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF0A0A0A)
        val onSurface = Color(0xFF0A0A0A)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 34.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium, lineHeight = 26.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.sp)
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
        val xxl = 32.dp
        val xxxl = 48.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 4.dp, 2.dp, 0.10f)
        val level2 = ShadowSpec(3.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 12.dp, 6.dp, 0.16f)
        val level4 = ShadowSpec(10.dp, 16.dp, 8.dp, 0.18f)
        val level5 = ShadowSpec(14.dp, 20.dp, 10.dp, 0.20f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class AssetMarker(val id: Int, val name: String, val type: String, val x: Float, val y: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val categories = remember { mutableStateListOf("Warehouse", "Device", "Office") }
    val enabledCats = remember { mutableStateListOf("Warehouse", "Device", "Office") }
    val markers = remember {
        listOf(
            AssetMarker(1, "Main Warehouse", "Warehouse", 0.18f, 0.34f),
            AssetMarker(2, "CNC-07", "Device", 0.52f, 0.46f),
            AssetMarker(3, "HQ Office", "Office", 0.75f, 0.62f),
            AssetMarker(4, "Spare Parts", "Warehouse", 0.33f, 0.78f)
        )
    }
    val assetName = remember { mutableStateOf("") }
    val assetCode = remember { mutableStateOf("") }
    val assetType = remember { mutableStateOf("Device") }
    val selectedId = remember { mutableStateOf<Int?>(null) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(text = "Asset Inventory", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                }
            )
        },
        bottomBar = {
            Surface(color = MaterialTheme.colorScheme.surface, tonalElevation = AppTokens.ElevationMapping.level2.elevation) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Button(
                        onClick = {
                            assetName.value = ""
                            assetCode.value = ""
                            assetType.value = "Device"
                            selectedId.value = null
                        },
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(48.dp).weight(1f)
                    ) {
                        Text(text = "Reset", style = MaterialTheme.typography.titleMedium)
                    }
                    Spacer(modifier = Modifier.size(AppTokens.Spacing.md))
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.height(48.dp).weight(1f)
                    ) {
                        Text(text = "Save Asset", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            LazyRow(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                contentPadding = PaddingValues(horizontal = 0.dp, vertical = 0.dp)
            ) {
                items(categories) { c ->
                    val isOn = enabledCats.contains(c)
                    FilterChip(
                        selected = isOn,
                        onClick = { if (isOn) enabledCats.remove(c) else enabledCats.add(c) },
                        label = {
                            Text(
                                text = c,
                                style = if (isOn) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium,
                                color = if (isOn) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface
                            )
                        },
                        shape = AppTokens.Shapes.small,
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
                        colors = FilterChipDefaults.filterChipColors(
                            containerColor = if (isOn) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface,
                            selectedContainerColor = MaterialTheme.colorScheme.primary
                        )
                    )
                }
            }
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                verticalAlignment = Alignment.Top
            ) {
                Column(
                    modifier = Modifier.weight(1f),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    TextField(
                        value = assetName.value,
                        onValueChange = { assetName.value = it },
                        label = { Text(text = "Asset Name") },
                        singleLine = true
                    )
                    TextField(
                        value = assetCode.value,
                        onValueChange = { assetCode.value = it },
                        label = { Text(text = "Asset Code") },
                        singleLine = true
                    )
                    TextField(
                        value = assetType.value,
                        onValueChange = { assetType.value = it },
                        label = { Text(text = "Asset Type") },
                        singleLine = true
                    )
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
                    ) {
                        Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                            Text(text = "Selected", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                            Text(text = selectedId.value?.let { id -> markers.firstOrNull { it.id == id }?.name ?: "None" } ?: "None", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                        }
                    }
                }
                BoxWithConstraints(
                    modifier = Modifier.weight(1f).heightIn(min = 360.dp).aspectRatio(0.9f).background(AppTokens.Colors.surface, AppTokens.Shapes.large).border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
                ) {
                    MapGridOverlay()
                    markers.filter { enabledCats.contains(it.type) }.forEach { m ->
                        MapMarker(
                            type = m.type,
                            selected = selectedId.value == m.id,
                            onClick = { selectedId.value = if (selectedId.value == m.id) null else m.id },
                            modifier = Modifier.offset(
                                x = maxWidth * m.x,
                                y = maxHeight * m.y
                            )
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun BoxScope.MapMarker(type: String, selected: Boolean, onClick: () -> Unit, modifier: Modifier) {
    val color = when (type) {
        "Warehouse" -> AppTokens.Colors.tertiary
        "Device" -> AppTokens.Colors.secondary
        else -> AppTokens.Colors.primary
    }
    Box(
        modifier = modifier.size(if (selected) 28.dp else 22.dp).background(color, CircleShape).border(2.dp, if (selected) AppTokens.Colors.primary else AppTokens.Colors.surface, CircleShape).align(Alignment.TopStart)
    )
    Card(
        onClick = onClick,
        modifier = modifier.offset(x = 18.dp, y = (-4).dp),
        shape = AppTokens.Shapes.small,
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
    ) {
        Text(text = type, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface, modifier = Modifier.padding(horizontal = AppTokens.Spacing.sm, vertical = AppTokens.Spacing.xs))
    }
}

@Composable
fun MapGridOverlay() {
    Column(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier.fillMaxWidth().height(1.dp).background(AppTokens.Colors.surfaceVariant))
        }
    }
    Row(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier.width(1.dp).fillMaxSize().background(AppTokens.Colors.surfaceVariant))
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}
