package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
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

private const val NAME = "167*ReliefFund*en"
private const val UI_TYPE = "Form"
private const val STYLE_THEME = "Muted Earth"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val COLOR_PALETTE = "primary:#B58B5A secondary:#E5C48F tertiary:#8BB39B background:#F6F0E3 surface:#FFFFFF surfaceVariant:#E7D7C2 outline:#C3B09E success:#6FB08C warning:#E6B566 error:#D96C5F onPrimary:#2D1A0D onSecondary:#2F230C onTertiary:#0E1A13 onBackground:#1E130C onSurface:#2A1C12"
private const val DENSITY_SPACING = "Compact"
private const val COMPLEXITY = "TextField,Stepper,CTA"
private const val EXTRA = "Muted civic relief form with stepper chips and submit CTA"

object DesignTokens {
    object Colors {
        val primary = Color(0xFFB58B5A)
        val secondary = Color(0xFFE5C48F)
        val tertiary = Color(0xFF8BB39B)
        val background = Color(0xFFF6F0E3)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE7D7C2)
        val outline = Color(0xFFC3B09E)
        val success = Color(0xFF6FB08C)
        val warning = Color(0xFFE6B566)
        val error = Color(0xFFD96C5F)
        val onPrimary = Color(0xFF2D1A0D)
        val onSecondary = Color(0xFF2F230C)
        val onTertiary = Color(0xFF0E1A13)
        val onBackground = Color(0xFF1E130C)
        val onSurface = Color(0xFF2A1C12)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold, lineHeight = 32.sp)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold, lineHeight = 26.sp)
        val title = TextStyle(fontSize = 15.sp, fontWeight = FontWeight.Medium, lineHeight = 20.sp)
        val body = TextStyle(fontSize = 13.sp, fontWeight = FontWeight.Normal, lineHeight = 18.sp)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(14.dp)
        val large = RoundedCornerShape(24.dp)
    }
    object Spacing {
        val xxs = 4.dp
        val xs = 8.dp
        val sm = 12.dp
        val md = 16.dp
        val lg = 20.dp
        val xl = 28.dp
        val xxl = 36.dp
        val xxxl = 48.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.18f)
        val level3 = ShadowSpec(12.dp, 12.dp, 6.dp, 0.22f)
        val level4 = ShadowSpec(18.dp, 18.dp, 8.dp, 0.26f)
        val level5 = ShadowSpec(24.dp, 24.dp, 10.dp, 0.3f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = DesignTokens.Colors.primary,
    onPrimary = DesignTokens.Colors.onPrimary,
    secondary = DesignTokens.Colors.secondary,
    onSecondary = DesignTokens.Colors.onSecondary,
    tertiary = DesignTokens.Colors.tertiary,
    onTertiary = DesignTokens.Colors.onTertiary,
    background = DesignTokens.Colors.background,
    onBackground = DesignTokens.Colors.onBackground,
    surface = DesignTokens.Colors.surface,
    onSurface = DesignTokens.Colors.onSurface,
    surfaceVariant = DesignTokens.Colors.surfaceVariant,
    outline = DesignTokens.Colors.outline,
    error = DesignTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = DesignTokens.TypographyTokens.display,
    headlineMedium = DesignTokens.TypographyTokens.headline,
    titleMedium = DesignTokens.TypographyTokens.title,
    bodyMedium = DesignTokens.TypographyTokens.body,
    labelMedium = DesignTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = DesignTokens.Shapes.small,
            small = DesignTokens.Shapes.small,
            medium = DesignTokens.Shapes.medium,
            large = DesignTokens.Shapes.large,
            extraLarge = DesignTokens.Shapes.large
        ),
        content = content
    )
}

data class FormStep(val title: String, val description: String)
data class SupportChip(val label: String)

data class SummaryItem(val label: String, val value: String)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                RootScreen()
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val steps = listOf(
        FormStep("Identity", "Applicant basics"),
        FormStep("Impact", "Community reach"),
        FormStep("Needs", "Immediate relief"),
        FormStep("Summary", "Confirm details")
    )
    val chips = listOf(SupportChip("Medical"), SupportChip("Shelter"), SupportChip("Food"), SupportChip("Utilities"))
    val summary = listOf(
        SummaryItem("Requested", "$4,500"),
        SummaryItem("Households", "36"),
        SummaryItem("Region", "North loop"),
        SummaryItem("Urgency", "48h")
    )
    var currentStep by remember { mutableStateOf(1) }
    var name by remember { mutableStateOf("") }
    var organization by remember { mutableStateOf("") }
    var contact by remember { mutableStateOf("") }
    var narrative by remember { mutableStateOf("") }
    var selectedChip by remember { mutableStateOf(0) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = MaterialTheme.colorScheme.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(text = "ReliefFund", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "Civic support intake", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(30.dp).clip(CircleShape).background(MaterialTheme.colorScheme.surfaceVariant))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(30.dp).clip(CircleShape).background(MaterialTheme.colorScheme.primary.copy(alpha = 0.35f)))
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.sm),
            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.md)
        ) {
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level2.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                    Text(text = "Steps", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    steps.forEachIndexed { index, step ->
                        val reached = index <= currentStep
                        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                Box(
                                    modifier = Modifier
                                        .size(26.dp)
                                        .clip(CircleShape)
                                        .background(if (reached) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceVariant)
                                ) {
                                    Text(text = "${index + 1}", modifier = Modifier.align(Alignment.Center), style = MaterialTheme.typography.labelMedium, color = if (reached) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface)
                                }
                                if (index != steps.lastIndex) {
                                    Box(modifier = Modifier.width(3.dp).height(28.dp).background(MaterialTheme.colorScheme.surfaceVariant))
                                }
                            }
                            Column(modifier = Modifier.weight(1f)) {
                                Text(text = step.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                Text(text = step.description, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                            }
                            Button(onClick = { currentStep = index }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary, contentColor = MaterialTheme.colorScheme.onSecondary), shape = DesignTokens.Shapes.small) {
                                Text(text = if (reached) "Edit" else "Go", style = MaterialTheme.typography.labelMedium)
                            }
                        }
                    }
                }
            }
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level1.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                    Text(text = "Focus", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                        chips.forEachIndexed { index, chip ->
                            val active = selectedChip == index
                            Box(
                                modifier = Modifier
                                    .clip(DesignTokens.Shapes.small)
                                    .background(if (active) MaterialTheme.colorScheme.primary.copy(alpha = 0.2f) else MaterialTheme.colorScheme.surfaceVariant)
                                    .border(1.dp, if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.outline, DesignTokens.Shapes.small)
                                    .padding(horizontal = DesignTokens.Spacing.md, vertical = DesignTokens.Spacing.xs)
                                    .clickable { selectedChip = index }
                            ) {
                                Text(text = chip.label, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                        }
                    }
                }
            }
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level2.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                    Text(text = "Applicant details", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    OutlinedTextField(value = name, onValueChange = { name = it }, label = { Text("Full name") }, modifier = Modifier.fillMaxWidth())
                    OutlinedTextField(value = organization, onValueChange = { organization = it }, label = { Text("Organization") }, modifier = Modifier.fillMaxWidth())
                    OutlinedTextField(value = contact, onValueChange = { contact = it }, label = { Text("Contact") }, modifier = Modifier.fillMaxWidth())
                    OutlinedTextField(value = narrative, onValueChange = { narrative = it }, label = { Text("Relief narrative") }, modifier = Modifier.fillMaxWidth(), minLines = 3)
                    Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                        Button(onClick = { if (currentStep > 0) currentStep -= 1 }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface), shape = DesignTokens.Shapes.medium, modifier = Modifier.weight(1f)) {
                            Text(text = "Back", style = MaterialTheme.typography.titleMedium)
                        }
                        Button(onClick = { if (currentStep < steps.lastIndex) currentStep += 1 }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary), shape = DesignTokens.Shapes.medium, modifier = Modifier.weight(1f)) {
                            Text(text = if (currentStep == steps.lastIndex) "Submit" else "Next", style = MaterialTheme.typography.titleMedium)
                        }
                    }
                }
            }
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level1.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xs)) {
                    Text(text = "Summary", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    summary.forEach { item ->
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .clip(DesignTokens.Shapes.medium)
                                .background(MaterialTheme.colorScheme.surfaceVariant)
                                .padding(DesignTokens.Spacing.sm),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(text = item.label, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            Text(text = item.value, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                        }
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewReliefFund() {
    AppTheme {
        RootScreen()
    }
}