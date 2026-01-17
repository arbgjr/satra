#!/usr/bin/env python3
"""
Assign GitHub issues to sprint milestones based on task breakdown.
"""
import subprocess
import yaml
import json
import time

def run_gh_command(cmd):
    """Execute gh CLI command and return output."""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        return None
    return result.stdout.strip()

# Load task breakdown
with open('.agentic_sdlc/projects/proj-75602fb4/planning/task-breakdown.yml') as f:
    data = yaml.safe_load(f)

task_breakdown = data['task_breakdown']

# Milestone mapping (milestone number -> sprint number)
milestone_map = {
    0: 2,  # Sprint 0 -> Milestone #2
    1: 3,  # Sprint 1 -> Milestone #3
    2: 4,  # Sprint 2 -> Milestone #4
    3: 5,  # Sprint 3 -> Milestone #5
    4: 6,  # Sprint 4 -> Milestone #6
    5: 7,  # Sprint 5 -> Milestone #7
    6: 8,  # Sprint 6 -> Milestone #8
}

# Build task -> milestone mapping
task_to_milestone = {}

# Sprint 0
if 'sprint_0_infrastructure' in task_breakdown:
    for task in task_breakdown['sprint_0_infrastructure']['tasks']:
        task_to_milestone[task['id']] = milestone_map[0]

# EPICs
for epic_key in ['epic_001_tasks', 'epic_002_tasks', 'epic_003_tasks', 'epic_004_tasks', 'epic_005_tasks']:
    if epic_key in task_breakdown:
        epic_data = task_breakdown[epic_key]
        for key, value in epic_data.items():
            if key.startswith('story_') and isinstance(value, dict):
                for task in value.get('tasks', []):
                    sprint_num = task.get('assigned_sprint', 1)
                    task_to_milestone[task['id']] = milestone_map.get(sprint_num, 3)

# Sprint 6
if 'sprint_6_polish' in task_breakdown:
    for task in task_breakdown['sprint_6_polish']['tasks']:
        task_to_milestone[task['id']] = milestone_map[6]

print(f"Mapping {len(task_to_milestone)} tasks to milestones...")
print()

# Get all issues
issues_json = run_gh_command('gh issue list --limit 200 --json number,title,milestone')
if not issues_json:
    print("Failed to fetch issues")
    exit(1)

issues = json.loads(issues_json)

updated_count = 0
skipped_count = 0

for issue in issues:
    issue_number = issue['number']
    issue_title = issue['title']

    # Extract task ID from title (format: [TASK-XXX] ...)
    if not issue_title.startswith('[TASK-'):
        skipped_count += 1
        continue

    task_id = issue_title.split(']')[0][1:]  # Extract TASK-XXX

    if task_id not in task_to_milestone:
        print(f"⚠ Issue #{issue_number} ({task_id}): No milestone mapping found")
        skipped_count += 1
        continue

    milestone_number = task_to_milestone[task_id]

    # Update issue milestone
    cmd = f'gh issue edit {issue_number} --milestone {milestone_number}'
    result = run_gh_command(cmd)

    if result:
        print(f"✓ Issue #{issue_number} ({task_id}) → Milestone #{milestone_number}")
        updated_count += 1
    else:
        print(f"✗ Failed to update issue #{issue_number}")

    time.sleep(0.3)  # Rate limiting

print()
print("="*60)
print(f"✓ Updated: {updated_count}")
print(f"⊘ Skipped: {skipped_count}")
print("="*60)
