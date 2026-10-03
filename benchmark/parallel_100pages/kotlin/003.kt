package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
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
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableIntStateOf
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

private const val NAME = "006_DashboardAnalytics_en"
private const val UI_TYPE = "Dashboard Analytics"
private const val STYLE_THEME = "Corporate Dashboard"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF0EA5E9)
        val secondary = Color(0xFF22C55E)
        val tertiary = Color(0xFFF59E0B)
        val background = Color(0xFFF7FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFEFF3F7)
        val outline = Color(0xFFD4D9E1)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF0F172A)
        val onTertiary = Color(0xFF111827)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, lineHeight = 30.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, lineHeight = 24.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 4.dp
        val md = 6.dp
        val lg = 8.dp
        val xl = 12.dp
        val xxl = 16.dp
        val xxxl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 0.5.dp, 0.12f)
        val level2 = ShadowSpec(2.dp, 4.dp, 1.dp, 0.14f)
        val level3 = ShadowSpec(3.dp, 6.dp, 1.5.dp, 0.16f)
        val level4 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.2f)
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

data class MetricCardUi(val id: Int, val title: String, val value: String, val delta: String, val color: Color)
data class ChartCardUi(val id: Int, val title: String, val color: Color)

@OptIn(ExperimentalMaterial3Api::class, ExperimentalLayoutApi::class)
@Composable
fun RootScreen() {
    val ranges = listOf("Today", "7 Days", "30 Days", "90 Days", "YTD", "Custom")
    val selectedRange = remember { mutableStateOf("7 Days") }
    val flags = remember { mutableStateListOf<String>() }
    val darkSwitch = remember { mutableStateOf(false) }
    val kpis = remember {
        listOf(
            MetricCardUi(1, "Revenue", "$24,560", "+8.2%", AppTokens.Colors.secondary),
            MetricCardUi(2, "Orders", "1,284", "+3.1%", AppTokens.Colors.primary),
            MetricCardUi(3, "Refunds", "42", "-1.4%", AppTokens.Colors.error),
            MetricCardUi(4, "Active Users", "8,921", "+5.6%", AppTokens.Colors.tertiary)
        )
    }
    val charts = remember {
        listOf(
            ChartCardUi(1, "Sales Trend", Color(0xFFE0F2FE)),
            ChartCardUi(2, "Conversion Funnel", Color(0xFFEFF6FF)),
            ChartCardUi(3, "Geo Distribution", Color(0xFFECFDF5)),
            ChartCardUi(4, "Device Breakdown", Color(0xFFFFFBEB))
        )
    }
    val notif = remember { mutableIntStateOf(2) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                        Box(modifier = Modifier.size(20.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                        Text(text = "Analytics", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                    }
                }
            )
        },
        bottomBar = {
            Surface(color = MaterialTheme.colorScheme.surface, tonalElevation = AppTokens.ElevationMapping.level3.elevation, shadowElevation = AppTokens.ElevationMapping.level3.elevation) {
                Row(modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                        Text(text = "Notifications", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "${notif.intValue} pending", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(onClick = { notif.intValue = 0 }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary, contentColor = MaterialTheme.colorScheme.onSecondary), shape = AppTokens.Shapes.large, modifier = Modifier.height(44.dp).width(140.dp)) {
                        Text(text = "Mark All Read", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), verticalArrangement = Arrangement.Top, horizontalAlignment = Alignment.Start) {
            FlowRow(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                ranges.forEach { r ->
                    val active = r == selectedRange.value
                    FilterChip(selected = active, onClick = { selectedRange.value = r }, label = { Text(text = r, style = if (active) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium, color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface) }, colors = FilterChipDefaults.filterChipColors(containerColor = if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface, selectedContainerColor = MaterialTheme.colorScheme.primary), shape = AppTokens.Shapes.medium, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline))
                }
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            FlowRow(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                Text(text = "Compare", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                AssistChip(onClick = { if (flags.contains("Prev Period")) flags.remove("Prev Period") else flags.add("Prev Period") }, label = { Text(text = "Prev Period", style = MaterialTheme.typography.labelMedium, color = if (flags.contains("Prev Period")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = if (flags.contains("Prev Period")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface))
                AssistChip(onClick = { if (flags.contains("Goal")) flags.remove("Goal") else flags.add("Goal") }, label = { Text(text = "Goal", style = MaterialTheme.typography.labelMedium, color = if (flags.contains("Goal")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = if (flags.contains("Goal")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface))
                Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                    Text(text = "Dark", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                    Switch(checked = darkSwitch.value, onCheckedChange = { darkSwitch.value = it }, colors = SwitchDefaults.colors(checkedThumbColor = MaterialTheme.colorScheme.onPrimary, checkedTrackColor = MaterialTheme.colorScheme.primary))
                }
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
            LazyVerticalGrid(columns = GridCells.Fixed(2), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)) {
                items(kpis) { m ->
                    Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 120.dp)) {
                        Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), horizontalAlignment = Alignment.Start) {
                            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                                Text(text = m.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                Box(modifier = Modifier.size(16.dp).background(m.color, AppTokens.Shapes.small))
                            }
                            Text(text = m.value, style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                            Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                                Box(modifier = Modifier.size(6.dp).background(if (m.delta.startsWith("+")) AppTokens.Colors.success else AppTokens.Colors.error, AppTokens.Shapes.small))
                                Text(text = m.delta, style = MaterialTheme.typography.labelMedium, color = if (m.delta.startsWith("+")) AppTokens.Colors.success else AppTokens.Colors.error)
                            }
                        }
                    }
                }
                items(charts) { c ->
                    Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 180.dp)) {
                        Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), horizontalAlignment = Alignment.Start) {
                            Text(text = c.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            Box(modifier = Modifier.fillMaxWidth().aspectRatio(1.6f).background(c.color, AppTokens.Shapes.medium), contentAlignment = Alignment.Center) {
                                Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                                    Box(modifier = Modifier.size(6.dp, 40.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                                    Box(modifier = Modifier.size(6.dp, 30.dp).background(AppTokens.Colors.secondary, AppTokens.Shapes.small))
                                    Box(modifier = Modifier.size(6.dp, 48.dp).background(AppTokens.Colors.tertiary, AppTokens.Shapes.small))
                                    Box(modifier = Modifier.size(6.dp, 22.dp).background(AppTokens.Colors.outline, AppTokens.Shapes.small))
                                    Box(modifier = Modifier.size(6.dp, 32.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                                    Box(modifier = Modifier.size(6.dp, 42.dp).background(AppTokens.Colors.secondary, AppTokens.Shapes.small))
                                }
                            }
                            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                                Box(modifier = Modifier.size(8.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                                Text(text = "Series A", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                                Box(modifier = Modifier.size(8.dp).background(AppTokens.Colors.secondary, AppTokens.Shapes.small))
                                Text(text = "Series B", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                        }
                    }
                }
            }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF, widthDp = 360, heightDp = 640)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}